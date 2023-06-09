#!/bin/bash

#socat TCP4-LISTEN:2202,fork,su=nobody TCP6:[2604:1380:4642:a300::32]:8080

#c3sxda-tc0
socat TCP4-LISTEN:2200,fork,su=nobody TCP6:[2604:1380:4642:a300::52]:22 &  
socat TCP4-LISTEN:8800,fork,su=nobody TCP6:[2604:1380:4642:a300::52]:8080 &  

#c3sxda-tc1
socat TCP4-LISTEN:2201,fork,su=nobody TCP6:[2604:1380:4642:a300::102]:22 &  
socat TCP4-LISTEN:8801,fork,su=nobody TCP6:[2604:1380:4642:a300::102]:8080 &  
#
#c3sxda-tc2
socat TCP4-LISTEN:2202,fork,su=nobody TCP6:[2604:1380:4642:a300::f2]:22 &
socat TCP4-LISTEN:8802,fork,su=nobody TCP6:[2604:1380:4642:a300::f2]:8080 &
#
#c3sxda-tc3
socat TCP4-LISTEN:2203,fork,su=nobody TCP6:[2604:1380:4642:a300::b2]:22 &
socat TCP4-LISTEN:8803,fork,su=nobody TCP6:[2604:1380:4642:a300::b2]:8080 &
#
##c3sxda-tc4
socat TCP4-LISTEN:2204,fork,su=nobody TCP6:[2604:1380:4642:a300::c2]:22 &
socat TCP4-LISTEN:8804,fork,su=nobody TCP6:[2604:1380:4642:a300::c2]:8080 &
#
#c3sxda-tc5
socat TCP4-LISTEN:2205,fork,su=nobody TCP6:[2604:1380:4642:a300::62]:22 &
socat TCP4-LISTEN:8805,fork,su=nobody TCP6:[2604:1380:4642:a300::62]:8080 &
#
#c3sxda-tc6
socat TCP4-LISTEN:2206,fork,su=nobody TCP6:[2604:1380:4642:a300::92]:22 &
socat TCP4-LISTEN:8806,fork,su=nobody TCP6:[2604:1380:4642:a300::92]:8080 &
#
#c3sxda-tc7
socat TCP4-LISTEN:2207,fork,su=nobody TCP6:[2604:1380:4642:a300::42]:22 &
socat TCP4-LISTEN:8807,fork,su=nobody TCP6:[2604:1380:4642:a300::42]:8080 &
#
#c3sxda-tc8
socat TCP4-LISTEN:2208,fork,su=nobody TCP6:[2604:1380:4642:a300::122]:22 &
socat TCP4-LISTEN:8808,fork,su=nobody TCP6:[2604:1380:4642:a300::122]:8080 &
#
#c3sxda-tc9
socat TCP4-LISTEN:2209,fork,su=nobody TCP6:[2604:1380:4642:a300::d2]:22 &
socat TCP4-LISTEN:8809,fork,su=nobody TCP6:[2604:1380:4642:a300::d2]:8080 &
#
#c3sxda-tc10
socat TCP4-LISTEN:2210,fork,su=nobody TCP6:[2604:1380:4642:a300::e2]:22 &
socat TCP4-LISTEN:8810,fork,su=nobody TCP6:[2604:1380:4642:a300::e2]:8080 &
#
#c3sxda-tc11
socat TCP4-LISTEN:2211,fork,su=nobody TCP6:[2604:1380:4642:a300::72]:22 &
socat TCP4-LISTEN:8811,fork,su=nobody TCP6:[2604:1380:4642:a300::72]:8080 &
#
#c3sxda-tc12
socat TCP4-LISTEN:2212,fork,su=nobody TCP6:[2604:1380:4642:a300::82]:22 &
socat TCP4-LISTEN:8812,fork,su=nobody TCP6:[2604:1380:4642:a300::82]:8080 &
#
#c3sxda-tc13
socat TCP4-LISTEN:2213,fork,su=nobody TCP6:[2604:1380:4642:a300::112]:22 &
socat TCP4-LISTEN:8813,fork,su=nobody TCP6:[2604:1380:4642:a300::112]:8080 &
#
#c3sxda-tc14
socat TCP4-LISTEN:2214,fork,su=nobody TCP6:[2604:1380:4642:a300::a2]:22 &
socat TCP4-LISTEN:8814,fork,su=nobody TCP6:[2604:1380:4642:a300::a2]:8080 &
#
#c3sxda-tc15
socat TCP4-LISTEN:2215,fork,su=nobody TCP6:[2604:1380:4642:a300::32]:22 &
socat TCP4-LISTEN:8815,fork,su=nobody TCP6:[2604:1380:4642:a300::32]:8080 &
#
#c3sxda-tc16
socat TCP4-LISTEN:2216,fork,su=nobody TCP6:[2604:1380:4642:a300::132]:22 &
socat TCP4-LISTEN:8816,fork,su=nobody TCP6:[2604:1380:4642:a300::132]:8080 &
#
#c3sxda-tc17
socat TCP4-LISTEN:2217,fork,su=nobody TCP6:[2604:1380:4642:a300::142]:22 &
socat TCP4-LISTEN:8817,fork,su=nobody TCP6:[2604:1380:4642:a300::142]:8080 &
#
#c3sxda-tc18
socat TCP4-LISTEN:2218,fork,su=nobody TCP6:[2604:1380:4642:a300::152]:22 &
socat TCP4-LISTEN:8818,fork,su=nobody TCP6:[2604:1380:4642:a300::152]:8080 &
#
#c3sxda-tc19
socat TCP4-LISTEN:2219,fork,su=nobody TCP6:[2604:1380:4642:a300::162]:22 &
socat TCP4-LISTEN:8819,fork,su=nobody TCP6:[2604:1380:4642:a300::162]:8080 &
#
#c3sxda-tc20
socat TCP4-LISTEN:2220,fork,su=nobody TCP6:[2604:1380:4642:a300::172]:22 &
socat TCP4-LISTEN:8820,fork,su=nobody TCP6:[2604:1380:4642:a300::172]:8080 &
