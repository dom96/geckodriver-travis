# geckodriver_travis

import jester, asyncdispatch, htmlgen

settings:
  port = Port(5555)

routes:
  get "/":
    resp h1(id="hello", "Hello World!")

runForever()