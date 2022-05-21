(func $str$access (param $self i32) (param $index i32) (result i32)
  (local $newstr i32)
  (local $buffer i32)
  ;; check if index is out of range
  (local.get $self)
  (i32.const 0) ;;0
  (call $load)
  (local.get $index)
  (call $assert_in_range)
  (local.set $newstr) ;; just scraping up the return
  ;; alloc space for new string and set 1 as length
  (i32.const 2)
  (call $alloc)
  (local.set $newstr)
  (local.get $newstr)
  (i32.const 0) ;;as
  (i32.const 1)
  (call $store)
  ;; get char from self and set it as the string for new string
  (i32.add (local.get $index) (local.get $self))
  (i32.const 1)
  (call $load)
  (local.set $buffer)
  (local.get $newstr)
  (i32.const 1)
  (local.get $buffer)
  (call $store)
  (local.get $newstr)
  (return))
(func $str$length (param $self i32) (result i32)
    (local.get $self)
    (call $assert_not_none)
    (i32.const 0)
    (call $load) ;; load the length of the string
    (return))
(func $str$lessthan (param $self i32) (param $rhs i32) (result i32)
    (local $selfLength i32)
    (local $i i32)
    (local.get $self)
    (i32.load)
    (local.set $selfLength)
    (i32.const 1)
    (local.set $i)
    (block 
        (loop 
            (br_if 1 (i32.le_s (local.get $i) (local.get $selfLength) )(i32.eqz) )
            (i32.load (i32.add (local.get $self) (local.get $i)))
            (i32.load (i32.add (local.get $rhs) (local.get $i)))
            (i32.gt_s)  ;;return false if l >= r
            (if (then (i32.const 0) (return)))
            (i32.add (local.get $i) (i32.const 1))(local.set $i)
            (br 0)
        )
    ) ;;end block and loop otherwise return 1
    (i32.const 1)
    (return))
(func $str$greaterthan (param $self i32) (param $rhs i32) (result i32)
    (local $selfLength i32)
    (local $rhsLength i32)
    (local $i i32)
    (local.get $self)
    (i32.load)
    (local.set $selfLength)
    
    (i32.const 1)
    (local.set $i)
    (block 
        (loop 
            (br_if 1 (i32.le_s (local.get $i) (local.get $selfLength) )(i32.eqz) )
            (i32.load (i32.add (local.get $self) (local.get $i)))
            (i32.load (i32.add (local.get $rhs) (local.get $i)))
            (i32.lt_s)  ;;return false if l < r
            (if (then (i32.const 0) (return)))
            (i32.add (local.get $i) (i32.const 1))(local.set $i)
            (br 0)
        )
    ) ;;end block and loop otherwise return 1
    (i32.const 1)
    (return))
(func $str$equalsto (param $self i32) (param $rhs i32) (result i32)
    (local $selfLength i32)
    (local $rhsLength i32)
    (local $i i32)
    (local.get $self)
    (i32.load)
    (local.set $selfLength)
    (local.get $rhs)
    (i32.load)
    (local.set $rhsLength)
    (i32.ne (local.get $selfLength) (local.get $rhsLength))
    (if
      (then
        i32.const 0
        return ;; if length is not equal, return false
      )
    )
    (i32.const 1)
    (local.set $i)
    (block 
        (loop 
            (br_if 1 (i32.le_s (local.get $i) (local.get $selfLength) )(i32.eqz) )
            (i32.load (i32.add (local.get $self) (local.get $i)))
            (i32.load (i32.add (local.get $rhs) (local.get $i)))
            (i32.ne)  ;;check if left and right character values are not equal
            (if (then (i32.const 0) (return)))
            (i32.add (local.get $i) (i32.const 1))(local.set $i)
            (br 0)
        )
    ) ;;end block and loop
    (i32.const 1)
    (return))

(func $str$concat (param $self i32) (param $rhs i32) (result i32)
  (local $newlen i32)
  (local $len1 i32)
  (local $len2 i32)
  (local $newstr i32)
  (local $i i32)
  (local $j i32)
  (local $char i32)
  (local.get $rhs)
  (call $assert_not_none)
  (local.get $self)
  (i32.const 0)
  (call $load)
  (local.set $len1)
  (local.get $rhs)
  (i32.const 0)
  (call $load)
  (local.set $len2)
  (i32.add (local.get $len1) (local.get $len2))
  (local.set $newlen)
  (local.get $newlen)
  (i32.const 4)
  (i32.div_s)
  (i32.const 1)
  (i32.add)
  (call $alloc)
  (local.set $newstr)
  ;; set length of new string
  (local.get $newstr)
  (i32.const 0)
  (local.get $newlen)
  (call $store)
  ;; concat from string 1
  (local.set $i (i32.const 0))
  (local.set $j (i32.const 0))
  (loop $loop1
    local.get $self
    (i32.add (i32.const 1) (local.get $i))
    (call $load)
    (local.set $char)
    (local.get $newstr)
    (i32.add (i32.const 1) (local.get $i))
    (local.get $char)
    (call $store)
    (local.set $i (i32.add (i32.const 1) (local.get $i)))
    (local.set $j (i32.add (i32.const 4) (local.get $j)))
    (i32.lt_s (local.get $j) (local.get $len1))
    br_if $loop1
  )

  ;; concat from string 2
  (local.set $i (i32.const 0))
  (local.set $j (i32.const 0))
  (loop $loop2
    local.get $rhs
    (i32.add (i32.const 1) (local.get $i))
    (call $load)
    (local.set $char)
    (i32.add (local.get $len1) (local.get $newstr))
    (i32.add (i32.const 1)(local.get $i))
    (local.get $char)
    (call $store)
    (local.set $i (i32.add (i32.const 1) (local.get $i)))
    (local.set $j (i32.add (i32.const 4) (local.get $j)))
    (i32.lt_s (local.get $j) (local.get $len2))
    br_if $loop2
  )

  (local.get $newstr)
  (return))
(func $str$copyconstructor (param $self i32) (param $rhs i32) (result i32)
(i32.const 0)
(return))