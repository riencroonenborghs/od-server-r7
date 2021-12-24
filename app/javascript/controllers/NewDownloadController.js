
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "url", "audio", "youtubeAudio", "audioFormat", "sub", "youtubeSub", "srtSub" ];

  urlChanged () {
    const url = this.urlTarget.value;
    if (url.match(/youtube|youtu\.be/)) {
      this.audioTarget.classList.remove("d-none");
      this.subTarget.classList.remove("d-none");
    } else {
      this.audioTarget.classList.add("d-none");
      this.subTarget.classList.add("d-none");
    }
  }

  audioChanged () {
    const audio = this.youtubeAudioTarget.checked;
    if (audio) {
      this.audioFormatTarget.classList.remove("d-none");
    } else {
      this.audioFormatTarget.classList.add("d-none");
    }
  }

  subChanged () {
    const sub = this.youtubeSubTarget.checked;
    if (sub) {
      this.srtSubTarget.classList.remove("d-none");
    } else {
      this.srtSubTarget.classList.add("d-none");
    }
  }
}
