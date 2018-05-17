# Package

version       = "0.1.0"
author        = "Dominik Picheta"
description   = "D"
license       = "MIT"
srcDir        = "src"

# Dependencies

requires "nim >= 0.18.0"
requires "jester 0.2.0"

# Test deps

requires "webdriver"

task test, "Runs web driver test":
  exec "nimble c -r tests/tester"