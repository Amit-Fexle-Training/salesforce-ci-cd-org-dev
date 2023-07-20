import { LightningElement, track } from 'lwc';
export default class VideoPlayerComponent extends LightningElement 
{
    @track videoLink = "https://drive.google.com/file/d/17G2cIOPNvl8y0kjfdd7o2ugZk6TTCQPP/preview";
    @track videoList = [
    { id: '1', title: 'Video 1', url: 'https://www.example.com/video1.mp4' },
    { id: '2', title: 'Video 2', url: 'https://www.example.com/video2.mp4' },
    { id: '3', title: 'Video 3', url: 'https://www.example.com/video3.mp4' },
    // Add more video objects as needed
  ];
  @track selectedVideoUrl = '';
  @track activeVideoIndex = 0;

  handleVideoClick(event) {
    const selectedIndex = event.currentTarget.dataset.index;
    this.activeVideoIndex = selectedIndex;
    this.selectedVideoUrl = this.videoList[selectedIndex].url;
  }
}