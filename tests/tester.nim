import options, osproc, streams, threadpool, os

import webdriver

proc runProcess(cmd: string) =
  let p = startProcess(
    cmd,
    options={
      poStdErrToStdOut,
      poEvalCommand
    }
  )

  let o = p.outputStream
  while p.running:
    echo cmd.substr(0, 10), ": ", o.readLine()

  p.close()

when isMainModule:
  spawn runProcess("nim c -r src/geckodriver_travis.nim")
  spawn runProcess("geckodriver -p 4444")
  defer:
    discard execCmd("killall geckodriver_travis")
    discard execCmd("killall geckodriver")

  echo("Waiting 5 seconds for servers")
  sleep(5000)

  try:
    let driver = newWebDriver()
    let session = driver.createSession()
    session.navigate("http://localhost:5555/")

    doAssert session.findElement("#hello").get().getText() == "Hello World!"

    session.close()
  except:
    sleep(10000) # See if we can grab any more output.
    raise