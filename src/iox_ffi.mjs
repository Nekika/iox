import * as fs from 'node:fs'

export function getLine(_prompt) {
  let buffer = Buffer.from([])

  let byte;
  while (byte !== null && byte !== 0x0A) {
    byte = readByte(process.stdin.fd)
    if (byte !== null) {
      buffer = Buffer.from([...buffer, byte])
    }
  }

  return buffer.toString()
}

function readByte(fd) {
  try {
    const buffer = Buffer.alloc(1)
    if (fs.readSync(fd, buffer) == 0) {
      return null
    }
    return buffer[0]
  } catch {
    return readByte(fd)
  }
}
