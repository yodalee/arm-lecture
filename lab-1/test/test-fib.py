#!/usr/bin/env python
# encoding: utf-8

import unittest
import subprocess

outputFmt = "The fibonacci sequence at %d is: %d\n"
runCmd = "qemu-arm -L /usr/arm-linux-gnueabihf ./../fibseq"

class TestFib(unittest.TestCase):
    def setUp(self):
        pass

    def testNormal(self):
        a = 0
        b = 1
        for i in range(10):
            p = subprocess.Popen(
                runCmd.split(), stdin=subprocess.PIPE, stdout=subprocess.PIPE)
            out = p.communicate(input=('%d' % (i)).encode())[0]
            self.assertEqual(out.decode("utf-8"), outputFmt % (i, a))
            a, b = b, a+b

    def testMinus(self):
        p = subprocess.Popen(
            runCmd.split(), stdin=subprocess.PIPE, stdout=subprocess.PIPE)
        out = p.communicate(input=('%d' % (-1)).encode())[0]
        self.assertEqual(out.decode("utf-8"), outputFmt % (-1, 0))

    def testOverflow(self):
        p = subprocess.Popen(
            runCmd.split(), stdin=subprocess.PIPE, stdout=subprocess.PIPE)
        out = p.communicate(input=("%d" % (47)).encode())[0]
        self.assertEqual(out.decode("utf-8"), outputFmt % (47, 0))

if __name__ == '__main__':
    unittest.main()
