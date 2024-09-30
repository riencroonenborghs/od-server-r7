import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "url", "audio", "youtubeAudio", "audioFormatLabel", "audioFormat", "sub", "youtubeSub", "srtSub", "srtSubLabel" ];

  urlChanged () {
    const url = this.urlTarget.value;

    if (url.match(/youtube\.com|youtu\.be/)) {
      this.audioTarget.classList.remove("hidden");
      this.subTarget.classList.remove("hidden");
    } else {
      this.audioTarget.classList.add("hidden");
      this.subTarget.classList.add("hidden");
    }
  }

  audioChanged () {
    if (this.youtubeAudioTarget.checked) {
      this.audioFormatTarget.disabled = false;
      this.audioFormatLabelTarget.classList.remove("text-slate-200");
    } else {
      this.audioFormatTarget.disabled = true;
      this.audioFormatLabelTarget.classList.add("text-slate-200");
    }
  }

  subChanged () {
    const sub = this.youtubeSubTarget.checked;
    if (sub) {
      this.srtSubTarget.disabled = false;
      this.srtSubLabelTarget.classList.remove("text-slate-200");
    } else {
      this.srtSubTarget.disabled = true;
      this.srtSubLabelTarget.classList.add("text-slate-200");
    }
  }
}
