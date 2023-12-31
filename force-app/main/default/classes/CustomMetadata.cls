/**
 * Copyright (c) 2017, Andrew Fawcett
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the Andrew Fawcett, nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/
/**
 *
    String deployId = 
      CustomMetadata.Operations
        .callback(
            // Platform event for deploy status
            MetadataDeployment__e.getSObjectType(),
            MetadataDeployment__e.DeploymentId__c,
            MetadataDeployment__e.Result__c)
        .enqueueUpsertRecords(
            // Custom Metadata object type
            WidgetPreset__mdt.getSObjectType(), 
            new List<Map<SObjectField, Object>> {
                // Custom Metadata record 
                new Map<SObjectField, Object> {
                    WidgetPreset__mdt.DeveloperName => 'BluetoohToothbrush',
                    WidgetPreset__mdt.Label => 'Bluetooh Toothbrush',
                    WidgetPreset__mdt.DefaultNotification__c => 'Good day!',
                    WidgetPreset__mdt.Alias__c => 'wdbtt' } } )
        .deployId;
            
    WidgetPreset__mdt readRecord = 
        [select DeveloperName, Label, DefaultNotification__c, Alias__c from WidgetPreset__mdt limit 1];

    String deployId = 
      CustomMetadata.Operations
        .callback(
            // Platform event for deploy status
            MetadataDeployment__e.getSObjectType(), 
            MetadataDeployment__e.DeploymentId__c,
            MetadataDeployment__e.Result__c)
        .enqueueUpsertRecords(
            new List<SObject> { readRecord } )
        .deployId;            
 **/                

global with sharing class CustomMetadata 
{
	global static final Operations Operations = new Operations();

    global class Operations {
        
        private SaveResultCallback deployCallback;
        
        global String deployId {get;private set;}
        
        private Operations() { }   
                
        /**
         * Takes a raw custom metadata record list and deploys it
         **/
        global Operations enqueueUpsertRecords(List<Metadata.CustomMetadata> records) {
            
            // TODO: Throw an exception if duplicates found
            // TODO: Throw exception if the callback has not been set
            Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
            for(Metadata.CustomMetadata record : records) {
                mdContainer.addMetadata(record);
            }
            // Caller will use this generated Id to associate the callback/event with this deployment 
            deployId = deployCallback.deployId;                        
            // Current return Id from platform is "DeployRequest" record, callback Id passed by platform is "AsyncApexJob"?
            Platform.metadatEnqueueDeployment(mdContainer, deployCallback);
            return this;
        } 

        /**
         * Leverages the fact that MDT SObject's can be bound and thus edited on a VF page!
         * And the hope that one day we can edit in memory native MDT SObject type fields ;-)
         **/
        global Operations enqueueUpsertRecords(List<SObject> records) {
            
            // TODO: Throw an exception for empty lists
            SObjectType sObjectType = records[0].getSObjectType();
            DescribeSObjectResult dsr = sObjectType.getDescribe();
            Map<String, SObjectField> fieldTokenByName = dsr.fields.getMap();
            List<Map<SObjectField, Object>> sObjectRecords = new List<Map<SObjectField, Object>>();
            for(SObject record: records) {
                Map<SObjectField, Object> valuesByField = new Map<SObjectField, Object>();
                Map<String, Object> populatedByField = record.getPopulatedFieldsAsMap();
                for(String fieldName : populatedByField.keySet()) {
                    if(fieldName == 'Id') {
                        continue;
                    }
                    SObjectField fieldToken = fieldTokenByName.get(fieldName);
                    Object fieldValue =  populatedByField.get(fieldName);
                    valuesByField.put(fieldToken, fieldValue);
                }
                sObjectRecords.add(valuesByField);           
            } 
            return enqueueUpsertRecords(sObjectType, sObjectRecords);
        } 
        
        /**
         * Deploy custom metadata records described as a field value pair (good for keeping referential integrity)
         * @param sobjectType the SObjectType of the MDT object via MyCustomMetadata__c.getSObjectType()
         * @param sobjectRecords the list of field value maps representing the records
         **/
        global Operations enqueueUpsertRecords(SObjectType sobjectType, List<Map<SObjectField, Object>> sObjectRecords) {
            
            List<Metadata.CustomMetadata> records = new List<Metadata.CustomMetadata>();            
            for (Map<SObjectField, Object> sObjectRecord : sObjectRecords) {
                Metadata.CustomMetadata customMetadataRecord = new Metadata.CustomMetadata();
                customMetadataRecord.values = new List<Metadata.CustomMetadataValue>();                                 
                for(SObjectField field : sObjectRecord.keySet()) {
                    DescribeFieldResult dsr = field.getDescribe();
                    Object fieldValue = sObjectRecord.get(field);
                    if(dsr.getName() == 'DeveloperName') {
                        customMetadataRecord.fullName = 
                            sobjectType.getDescribe().getName().replace('__mdt', '') + '.' + fieldValue;                   
                    } else if(dsr.getName() == 'Label') {
                        customMetadataRecord.label = (String) fieldValue;                  
                    } else {                
                        Metadata.CustomMetadataValue cmv = new Metadata.CustomMetadataValue();
                        cmv.field = dsr.getName();
                        cmv.value = dsr.soapType == Schema.SoapType.ID ? String.valueOf(fieldValue) : fieldValue;
                        customMetadataRecord.values.add(cmv);
                    }
                }           
                records.add(customMetadataRecord);
            }
            return enqueueUpsertRecords(records) ;
        }
        
        /** 
         * Registers a custom callback implementation 
         **/
        global Operations callback(SaveResultCallback saveResultCallback) {
            this.deployCallback = saveResultCallback;
            return this;
        }
        
        /**
         * Fires the given Platform Event populating the given message field with a 
         *   JSON serialised representation of SaveRecordResult
         **/
        global Operations callback(SObjectType eventType, SObjectField deploymentIdField, SObjectField messageField) {
            return callback(new PublishEventCallback(eventType, deploymentIdField, messageField));
        }        
    }    
    
    /**
     * Example callback to dump results to debug log
     **/
    global class DebugCallback extends SaveResultCallback {
        public override void handleResult(String deployId, List<SaveRecordResult> results) {
            System.debug('Deploy Id is ' + deployId);
            for(SaveRecordResult result : results) {
                System.debug('Fullname of custom metadata reocord is ' + result.fullName);
                System.debug('Success is ' + result.success);
                if(!result.success) {
                    System.debug('Message is' + result.message);                                    
                }
            }            
        }
    }
    
    /**
     * Sends a Platform Event in response to a Metadata Deploy callback
     **/
    global class PublishEventCallback extends SaveResultCallback {
        
        private SObjectType eventType;
        private SObjectField messageField;
        private SObjectFIeld deploymentIdField;
        
        global PublishEventCallback(SObjectType eventType, SObjectField deploymentIdField, SObjectField messageField) {
            this.eventType = eventType;
            this.messageField = messageField;
            this.deploymentIdField = deploymentIdField;
        }
        
        public override void handleResult(String deployId, List<SaveRecordResult> result) {
            // Create event to publish
            SObject event = eventType.newSObject();
            event.put(deploymentIdField, deployId);
            event.put(messageField, JSON.serialize(result, true));
            // Call method to publish events
            List<Database.SaveResult> results = Platform.eventBusPublish(new List<SObject> { event });
            // Inspect publishing result for each event
            // TODO: Consider another way to report this, since this is the phantom user context, options are limited
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    System.debug('Successfully published event.');
                } else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Error returned: ' +
                            err.getStatusCode() +
                            err.getMessage());
                    }
                }       
            }                               
        }
    }   
    
    /**
     * Base class handler for internal and external handlers, 
     *   marshalls internal deploy results into something easier to handle
     **/
    global abstract class SaveResultCallback implements Metadata.DeployCallback         
    {
        global String deployId {get; private set;}
        
        global SaveResultCallback() {
            // Credit: https://success.salesforce.com/ideaView?id=08730000000KgTYAA0
            deployId = EncodingUtil.convertToHex(Crypto.generateAesKey(128));    
        }
        
        public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
            List<SaveRecordResult> saveRecordResults = new List<SaveRecordResult>();
            for(Metadata.DeployMessage deployMessage : result.details.componentFailures) {
                if(deployMessage.fileName == 'package.xml') {
                    continue;
                }
	            saveRecordResults.add(convertToSaveResult(deployMessage));                 
            }
            for(Metadata.DeployMessage deployMessage : result.details.componentSuccesses) {
                if(deployMessage.fileName == 'package.xml') {
                    continue;
                }
                saveRecordResults.add(convertToSaveResult(deployMessage));                 
            }
            handleResult(deployId, saveRecordResults);
        }
        
        private SaveRecordResult convertToSaveResult(Metadata.DeployMessage deployMessage) {
            SaveRecordResult srr = new SaveRecordResult();
            srr.fullName = deployMessage.fullName;
            srr.success = deployMessage.success;
            srr.message = deployMessage.problem;
            return srr;            
        }
        
        /**
         * Handler for simplified metadata deployment result based around custom metadata records
         **/
        global abstract void handleResult(String deployId, List<SaveRecordResult> results);
    }
    
    global class SaveRecordResult {
        @AuraEnabled
        // TODO: Maybe resolve to the SObjectType and avoid namespace issues, does this marshal via Aura though?
        global String fullName;
        @AuraEnabled
        global Boolean success;
        @AuraEnabled
        global String message;
    }
    
    global class CustomMetadataException extends Exception {}
    
    /**
     * Basic dependency injection impl for platform APIs leveraged by this class
     **/
    @TestVisible
    private static Platform Platform = new RuntimePlatform();    
    @TestVisible
    private abstract class Platform {
        public abstract List<Database.SaveResult> eventBusPublish(List<SObject> events);
        public abstract Id metadatEnqueueDeployment(Metadata.DeployContainer mdContainer, Metadata.DeployCallback deployCallback);
    }
    private class RuntimePlatform extends Platform {
        public override List<Database.SaveResult> eventBusPublish(List<SObject> events) {
            return System.EventBus.publish(events);
        }
        public override Id metadatEnqueueDeployment(Metadata.DeployContainer mdContainer, Metadata.DeployCallback deployCallback) {
            return Metadata.Operations.enqueueDeployment(mdContainer, deployCallback);
        }
    }    
}