// Copyright (C) 2019 Toitware ApS. All rights reserved.

// This is a positive test.
// We want to make sure that the type-checker doesn't complain when
// we use `Object` methods on interfaces.

import expect show *

interface I:

class A implements I:

create_I -> I: return A

main:
  a := create_I
  expect a == a
  str := a.stringify
  expect (str.starts_with "an instance")

  exit 1