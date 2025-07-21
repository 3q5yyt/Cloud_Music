//秒转分钟
export default function  formatTime(totalSeconds:number|undefined):string{
  if(totalSeconds != undefined) {
    totalSeconds = Math.floor(totalSeconds/1000)
    const minutes: number = Math.floor(totalSeconds / 60)
    const seconds: number = totalSeconds % 60
    if (minutes < 10) {
      if (seconds < 10) {
        return `0${minutes}:0${seconds}`
      }
      return `0${minutes}:${seconds}`
    }
    return `${minutes}:${seconds}`
  }
  return "0";
}