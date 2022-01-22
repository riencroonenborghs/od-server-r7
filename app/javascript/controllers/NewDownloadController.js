import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "url", "audio", "youtubeAudio", "audioFormat", "sub", "youtubeSub", "srtSub" ];

  urlChanged () {
    const url = this.urlTarget.value;
    if (url.match(/youtube\.com|youtu\.be/)) {
      this.audioTarget.classList.remove("is-hidden");
      this.subTarget.classList.remove("is-hidden");
    } else {
      this.audioTarget.classList.add("is-hidden");
      this.subTarget.classList.add("is-hidden");
    }
  }

  audioChanged () {
    const audio = this.youtubeAudioTarget.checked;
    if (audio) {
      this.audioFormatTarget.disabled = false;
    } else {
      this.audioFormatTarget.disabled = true;
    }
  }

  subChanged () {
    const sub = this.youtubeSubTarget.checked;
    if (sub) {
      this.srtSubTarget.disabled = false;
    } else {
      this.srtSubTarget.disabled = true;
    }
  }
}
