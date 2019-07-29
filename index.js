const fs = require('fs')
const timecodes = require('node-timecodes')

const events = []

let count = 0

let sub = 0

let start = null
let end = null
let evtc = null
let evstr = null

const newX = /\[ \d+\.\d+\,/g
const afterMe = /\"\w.*\"/g

fs.readFileSync('log.scd').toString().split('\n').forEach(line => {
  console.log(count, line)
  if (line==='[') {
    console.log('THIS IS OUR START')
  }

  if (line.includes('[ ')) {
    console.log('NEW EXECUTION!')
    start = count
    const regMatch = line.match(newX)
    if (regMatch) {
      console.log('FUCKKKKKKKKKKKKKKKYAAAAAAAAAAAAAAAAAAAAA')
      const after = line.match(afterMe)
      evtc = parseFloat(regMatch[0].replace('[ ', '').replace(',', ''))
      if (after != null) {
        evstr = after[0].replace('"', '').replace('"', '')
      }
    }
  }

  const splLine = line.split('')
  if (splLine.pop() === ',' && splLine[splLine.length-1] === ']') {
    console.log('END EXECUTION!')
    end = count
  }

  if (start != null && end != null) {
    if (evstr) {
      events.push([parseFloat(parseFloat(evtc).toFixed(3)), evstr])
      // events.push([start, end, evtc, evstr])
    }
    start = null
    end = null
    evtc = null
    evstr = null
  }

  count += 1
})

console.log(events)

let outString = ''

events.forEach(ev => {
  const fixSt = `${timecodes.fromSeconds(ev[0]).split(':').splice(0,3).join(':') + '.000'}`
  const fixEn = `${timecodes.fromSeconds(ev[0] + 2.0).split(':').splice(0,3).join(':') + '.000'}`
  outString = outString + `\n${sub++}\n${fixSt} --> ${fixEn}\n${ev[1]}\n`
})

console.log(outString)

fs.writeFileSync('test.srt', outString)
