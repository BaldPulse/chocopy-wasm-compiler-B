(module
    (memory (import "js" "mem") 1)
    (func $alloc (import "libmemory" "alloc") (param i32) (result i32))
    (func $load (import "libmemory" "load") (param i32) (param i32) (result i32))
    (func $store (import "libmemory" "store") (param i32) (param i32) (param i32))


    (func (export "set$add") (param $baseAddr i32) (param $key i32) (result i32)
        (local $nodePtr i32)
        (local $tagHitFlag i32)
        (local $$allocPointer i32)
        (i32.const 0)
        (local.set $tagHitFlag)
        (local.get $baseAddr)
        (local.get $key)
        (i32.const 10)
        (i32.rem_u)
        (i32.mul (i32.const 4))
        (i32.add)
        (i32.load)
        (i32.const 0)
        (i32.eq)
        (if
            (then
                (i32.const 2)   ;; size in bytes
                (call $alloc)
                (local.tee $$allocPointer)
                (local.get $key)
                (i32.store)
                (local.get $$allocPointer)
                (i32.const 4)
                (i32.add)
                (i32.const 0)
                (i32.store)
                (local.get $baseAddr)
                (local.get $key)
                (i32.const 10)
                (i32.rem_u)
                (i32.mul (i32.const 4))
                (i32.add)
                (local.get $$allocPointer)
                (i32.store)
            )
            (else
                (local.get $baseAddr)
                (local.get $key)
                (i32.const 10)
                (i32.rem_u)
                (i32.mul (i32.const 4))
                (i32.add)
                (i32.load)
                (i32.load)
                (local.get $key)
                (i32.eq)
                (if
                    (then
                    (i32.const 1)
                    (local.set $tagHitFlag)
                    )
                )
                (local.get $baseAddr)
                (local.get $key)
                (i32.const 10)
                (i32.rem_u)
                (i32.mul (i32.const 4))
                (i32.add)
                (i32.load)
                (i32.const 4)
                (i32.add)
                (local.set $nodePtr)
                (block
                    (loop
                        (local.get $nodePtr)
                        (i32.load)
                        (i32.const 0)
                        (i32.ne)
                        (if
                            (then
                            (local.get $nodePtr)
                            (i32.load)
                            (i32.load)
                            (local.get $key)
                            (i32.eq)
                            (if
                                (then
                                (i32.const 1)
                                (local.set $tagHitFlag)
                                )
                            )
                            (local.get $nodePtr)
                            (i32.load)
                            (i32.const 4)
                            (i32.add)
                            (local.set $nodePtr)
                            )
                        )
                        (br_if 0
                            (local.get $nodePtr)
                            (i32.load)
                            (i32.const 0)
                            (i32.ne)
                        )
                        (br 1)
                    )
                )
                (local.get $tagHitFlag)
                (i32.const 0)
                (i32.eq)
                (if
                    (then
                        (i32.const 2)   ;; size in bytes
                        (call $alloc)
                        (local.tee $$allocPointer)
                        (local.get $key)
                        (i32.store)
                        (local.get $$allocPointer)
                        (i32.const 4)
                        (i32.add)
                        (i32.const 0)
                        (i32.store)
                        (local.get $nodePtr)
                        (local.get $$allocPointer)
                        (i32.store)
                    )
                )
            )
        )
        (i32.const 0)
        (return)
    )

    (func (export "set$contains") (param $baseAddr i32) (param $key i32) (result i32)
        (local $nodePtr i32)
        (local $tagHitFlag i32)
        (local $$allocPointer i32)
        (i32.const 0)
        (local.set $tagHitFlag)
        (local.get $baseAddr)
        (local.get $key)
        (i32.const 10)
        (i32.rem_u)
        (i32.mul (i32.const 4))
        (i32.add)
        (i32.load)
        (i32.const 0)
        (i32.eq)
        (if
            (then
            )
            (else
                (local.get $baseAddr)
                (local.get $key)
                (i32.const 10)
                (i32.rem_u)
                (i32.mul (i32.const 4))
                (i32.add)
                (i32.load)
                (i32.load)
                (local.get $key)
                (i32.eq)
                (if
                    (then
                        (i32.const 1)
                        (local.set $tagHitFlag)
                    )
                )
                (local.get $baseAddr)
                (local.get $key)
                (i32.const 10)
                (i32.rem_u)
                (i32.mul (i32.const 4))
                (i32.add)
                (i32.load)
                (i32.const 4)
                (i32.add)
                (local.set $nodePtr)
                (block
                    (loop
                        (local.get $nodePtr)
                        (i32.load)
                        (i32.const 0)
                        (i32.ne)
                        (if
                            (then
                                (local.get $nodePtr)
                                (i32.load)
                                (i32.load)
                                (local.get $key)
                                (i32.eq)
                                (if
                                    (then
                                        (i32.const 1)
                                        (local.set $tagHitFlag)
                                    )
                                )
                                (local.get $nodePtr)
                                (i32.load)
                                (i32.const 4)
                                (i32.add)
                                (local.set $nodePtr)
                            )
                        )
                        (br_if 0
                            (local.get $nodePtr)
                            (i32.load)
                            (i32.const 0)
                            (i32.ne)
                        )
                        (br 1)
                    )
                )
            )
        )
        (local.get $tagHitFlag)
        (return)
    )

    (func (export "set$length") (param $baseAddr i32) (result i32)
        (local $length i32)
        (local $nodePtr i32)
        (local $i i32)
        (loop $my_loop
            (local.get $baseAddr)
            (local.get $i)
            (i32.mul (i32.const 4))
            (i32.add)
            (i32.load)
            (i32.const 0)
            (i32.eq)
            (if
                (then
                )
                (else
                    (i32.const 1)
                    (local.get $length)
                    (i32.add)
                    (local.set $length)
                    (local.get $baseAddr)
                    (local.get $i)
                    (i32.mul (i32.const 4))
                    (i32.add)
                    (i32.load)
                    (i32.const 4)
                    (i32.add)
                    (local.set $nodePtr)
                    (block
                        (loop
                            (local.get $nodePtr)
                            (i32.load)
                            (i32.const 0)
                            (i32.ne)
                            (if
                                (then
                                    (local.get $length)
                                    (i32.const 1)
                                    (i32.add)
                                    (local.set $length)
                                    (local.get $nodePtr)
                                    (i32.load)
                                    (i32.const 4)
                                    (i32.add)
                                    (local.set $nodePtr)
                                )
                            )
                            (br_if 0
                                (local.get $nodePtr)
                                (i32.load)
                                (i32.const 0)
                                (i32.ne)
                            )
                            (br 1)
                        )
                    )
                )
            )
            (local.get $i)
            (i32.const 1)
            (i32.add)
            (local.set $i)
            (local.get $i)
            (i32.const 10)
            (i32.lt_s)
            (br_if $my_loop)
        )
        (local.get $length)
        (return)
    )

    (func (export "set$remove") (param $baseAddr i32) (param $key i32) (result i32)
        (local $prevPtr i32)
        (local $currPtr i32)
        (local.get $baseAddr)
        (local.get $key)
        (i32.const 10)
        (i32.rem_u)
        (i32.mul (i32.const 4))
        (i32.add)
        (local.set $prevPtr)
        (local.get $prevPtr)
        (i32.load)
        (i32.const 0)
        (i32.eq)
        (if
            (then
            )
            (else
                (local.get $prevPtr)
                (i32.load)
                (local.set $currPtr)
                (block
                    (loop
                        (local.get $currPtr)
                        (i32.load)
                        (local.get $key)
                        (i32.eq)
                        (if
                            (then
                                (local.get $prevPtr)
                                (local.get $currPtr)
                                (i32.const 4)
                                (i32.add)
                                (i32.load)
                                (i32.store)
                                (local.get $currPtr)
                                (i32.const 4)
                                (i32.add)
                                (local.set $prevPtr)
                                (local.get $currPtr)
                                (i32.const 4)
                                (i32.add)
                                (i32.load)
                                (local.set $currPtr)
                            )
                        )
                        (br_if 0
                            (local.get $currPtr)
                            (i32.const 0)
                            (i32.ne)
                        )
                        (br 1)
                    )
                )
            )
        )
        (i32.const 0)
        (return)
    )

)