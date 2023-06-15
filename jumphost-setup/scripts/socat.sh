#!/bin/bash

#socat TCP4-LISTEN:2202,fork,su=nobody TCP6:[2604:1380:4642:a300::32]:8080

#c3sxda-tc0
socat TCP4-LISTEN:2200,fork,su=nobody TCP6:[2604:1380:4642:a300::52]:22 &  
socat TCP4-LISTEN:8800,fork,su=nobody TCP6:[2604:1380:4642:a300::52]:8080 &  
socat TCP4-LISTEN:30000,fork,su=nobody TCP6:[2604:1380:4642:a300::52]:30000 &  
socat TCP4-LISTEN:30001,fork,su=nobody TCP6:[2604:1380:4642:a300::52]:30001 &

#c3sxda-tc1
socat TCP4-LISTEN:2201,fork,su=nobody TCP6:[2604:1380:4642:a300::102]:22 &  
socat TCP4-LISTEN:8801,fork,su=nobody TCP6:[2604:1380:4642:a300::102]:8080 &  
socat TCP4-LISTEN:30100,fork,su=nobody TCP6:[2604:1380:4642:a300::102]:30000 &  
socat TCP4-LISTEN:30101,fork,su=nobody TCP6:[2604:1380:4642:a300::102]:30001 &  
#
#c3sxda-tc2
socat TCP4-LISTEN:2202,fork,su=nobody TCP6:[2604:1380:4642:a300::f2]:22 &
socat TCP4-LISTEN:8802,fork,su=nobody TCP6:[2604:1380:4642:a300::f2]:8080 &
socat TCP4-LISTEN:30200,fork,su=nobody TCP6:[2604:1380:4642:a300::f2]:30000 &
socat TCP4-LISTEN:30201,fork,su=nobody TCP6:[2604:1380:4642:a300::f2]:30001 &
#
#c3sxda-tc3
socat TCP4-LISTEN:2203,fork,su=nobody TCP6:[2604:1380:4642:a300::b2]:22 &
socat TCP4-LISTEN:8803,fork,su=nobody TCP6:[2604:1380:4642:a300::b2]:8080 &
socat TCP4-LISTEN:30300,fork,su=nobody TCP6:[2604:1380:4642:a300::b2]:30000 &
socat TCP4-LISTEN:30301,fork,su=nobody TCP6:[2604:1380:4642:a300::b2]:30001 &
#
##c3sxda-tc4
socat TCP4-LISTEN:2204,fork,su=nobody TCP6:[2604:1380:4642:a300::c2]:22 &
socat TCP4-LISTEN:8804,fork,su=nobody TCP6:[2604:1380:4642:a300::c2]:8080 &
socat TCP4-LISTEN:30400,fork,su=nobody TCP6:[2604:1380:4642:a300::c2]:30000 &
socat TCP4-LISTEN:30401,fork,su=nobody TCP6:[2604:1380:4642:a300::c2]:30001 &
#
#c3sxda-tc5
socat TCP4-LISTEN:2205,fork,su=nobody TCP6:[2604:1380:4642:a300::62]:22 &
socat TCP4-LISTEN:8805,fork,su=nobody TCP6:[2604:1380:4642:a300::62]:8080 &
socat TCP4-LISTEN:30500,fork,su=nobody TCP6:[2604:1380:4642:a300::62]:30000 &
socat TCP4-LISTEN:30501,fork,su=nobody TCP6:[2604:1380:4642:a300::62]:30001 &
#
#c3sxda-tc6
socat TCP4-LISTEN:2206,fork,su=nobody TCP6:[2604:1380:4642:a300::92]:22 &
socat TCP4-LISTEN:8806,fork,su=nobody TCP6:[2604:1380:4642:a300::92]:8080 &
socat TCP4-LISTEN:30600,fork,su=nobody TCP6:[2604:1380:4642:a300::92]:30000 &
socat TCP4-LISTEN:30601,fork,su=nobody TCP6:[2604:1380:4642:a300::92]:30001 &
#
#c3sxda-tc7
socat TCP4-LISTEN:2207,fork,su=nobody TCP6:[2604:1380:4642:a300::42]:22 &
socat TCP4-LISTEN:8807,fork,su=nobody TCP6:[2604:1380:4642:a300::42]:8080 &
socat TCP4-LISTEN:30700,fork,su=nobody TCP6:[2604:1380:4642:a300::42]:30000 &
socat TCP4-LISTEN:30701,fork,su=nobody TCP6:[2604:1380:4642:a300::42]:30001 &
#
#c3sxda-tc8
socat TCP4-LISTEN:2208,fork,su=nobody TCP6:[2604:1380:4642:a300::122]:22 &
socat TCP4-LISTEN:8808,fork,su=nobody TCP6:[2604:1380:4642:a300::122]:8080 &
socat TCP4-LISTEN:30800,fork,su=nobody TCP6:[2604:1380:4642:a300::122]:30000 &
socat TCP4-LISTEN:30801,fork,su=nobody TCP6:[2604:1380:4642:a300::122]:30001 &
#
#c3sxda-tc9
socat TCP4-LISTEN:2209,fork,su=nobody TCP6:[2604:1380:4642:a300::d2]:22 &
socat TCP4-LISTEN:8809,fork,su=nobody TCP6:[2604:1380:4642:a300::d2]:8080 &
socat TCP4-LISTEN:30900,fork,su=nobody TCP6:[2604:1380:4642:a300::d2]:30000 &
socat TCP4-LISTEN:30901,fork,su=nobody TCP6:[2604:1380:4642:a300::d2]:30001 &
#
#c3sxda-tc10
socat TCP4-LISTEN:2210,fork,su=nobody TCP6:[2604:1380:4642:a300::e2]:22 &
socat TCP4-LISTEN:8810,fork,su=nobody TCP6:[2604:1380:4642:a300::e2]:8080 &
socat TCP4-LISTEN:31000,fork,su=nobody TCP6:[2604:1380:4642:a300::e2]:30000 &
socat TCP4-LISTEN:31001,fork,su=nobody TCP6:[2604:1380:4642:a300::e2]:30001 &
#
#c3sxda-tc11
socat TCP4-LISTEN:2211,fork,su=nobody TCP6:[2604:1380:4642:a300::72]:22 &
socat TCP4-LISTEN:8811,fork,su=nobody TCP6:[2604:1380:4642:a300::72]:8080 &
socat TCP4-LISTEN:31100,fork,su=nobody TCP6:[2604:1380:4642:a300::72]:30000 &
socat TCP4-LISTEN:31101,fork,su=nobody TCP6:[2604:1380:4642:a300::72]:30001 &
#
#c3sxda-tc12
socat TCP4-LISTEN:2212,fork,su=nobody TCP6:[2604:1380:4642:a300::82]:22 &
socat TCP4-LISTEN:8812,fork,su=nobody TCP6:[2604:1380:4642:a300::82]:8080 &
socat TCP4-LISTEN:31200,fork,su=nobody TCP6:[2604:1380:4642:a300::82]:31200 &
socat TCP4-LISTEN:31201,fork,su=nobody TCP6:[2604:1380:4642:a300::82]:31201 &
#
#c3sxda-tc13
socat TCP4-LISTEN:2213,fork,su=nobody TCP6:[2604:1380:4642:a300::112]:22 &
socat TCP4-LISTEN:8813,fork,su=nobody TCP6:[2604:1380:4642:a300::112]:8080 &
socat TCP4-LISTEN:31300,fork,su=nobody TCP6:[2604:1380:4642:a300::112]:30000 &
socat TCP4-LISTEN:31301,fork,su=nobody TCP6:[2604:1380:4642:a300::112]:30001 &
#
#c3sxda-tc14
socat TCP4-LISTEN:2214,fork,su=nobody TCP6:[2604:1380:4642:a300::a2]:22 &
socat TCP4-LISTEN:8814,fork,su=nobody TCP6:[2604:1380:4642:a300::a2]:8080 &
socat TCP4-LISTEN:31400,fork,su=nobody TCP6:[2604:1380:4642:a300::a2]:30000 &
socat TCP4-LISTEN:31401,fork,su=nobody TCP6:[2604:1380:4642:a300::a2]:30001 &
#
#c3sxda-tc15
socat TCP4-LISTEN:2215,fork,su=nobody TCP6:[2604:1380:4642:a300::32]:22 &
socat TCP4-LISTEN:8815,fork,su=nobody TCP6:[2604:1380:4642:a300::32]:8080 &
socat TCP4-LISTEN:31500,fork,su=nobody TCP6:[2604:1380:4642:a300::32]:30000 &
socat TCP4-LISTEN:31501,fork,su=nobody TCP6:[2604:1380:4642:a300::32]:30001 &
#
#c3sxda-tc16
socat TCP4-LISTEN:2216,fork,su=nobody TCP6:[2604:1380:4642:a300::132]:22 &
socat TCP4-LISTEN:8816,fork,su=nobody TCP6:[2604:1380:4642:a300::132]:8080 &
socat TCP4-LISTEN:31600,fork,su=nobody TCP6:[2604:1380:4642:a300::132]:30000 &
socat TCP4-LISTEN:31601,fork,su=nobody TCP6:[2604:1380:4642:a300::132]:30001 &
#
#c3sxda-tc17
socat TCP4-LISTEN:2217,fork,su=nobody TCP6:[2604:1380:4642:a300::142]:22 &
socat TCP4-LISTEN:8817,fork,su=nobody TCP6:[2604:1380:4642:a300::142]:8080 &
socat TCP4-LISTEN:31700,fork,su=nobody TCP6:[2604:1380:4642:a300::142]:30000 &
socat TCP4-LISTEN:31701,fork,su=nobody TCP6:[2604:1380:4642:a300::142]:30001 &
#
#c3sxda-tc18
socat TCP4-LISTEN:2218,fork,su=nobody TCP6:[2604:1380:4642:a300::152]:22 &
socat TCP4-LISTEN:8818,fork,su=nobody TCP6:[2604:1380:4642:a300::152]:8080 &
socat TCP4-LISTEN:31800,fork,su=nobody TCP6:[2604:1380:4642:a300::152]:30000 &
socat TCP4-LISTEN:31801,fork,su=nobody TCP6:[2604:1380:4642:a300::152]:30001 &
#
#c3sxda-tc19
socat TCP4-LISTEN:2219,fork,su=nobody TCP6:[2604:1380:4642:a300::162]:22 &
socat TCP4-LISTEN:8819,fork,su=nobody TCP6:[2604:1380:4642:a300::162]:8080 &
socat TCP4-LISTEN:31900,fork,su=nobody TCP6:[2604:1380:4642:a300::162]:30000 &
socat TCP4-LISTEN:31901,fork,su=nobody TCP6:[2604:1380:4642:a300::162]:30001 &
#
#c3sxda-tc20
socat TCP4-LISTEN:2220,fork,su=nobody TCP6:[2604:1380:4642:a300::172]:22 &
socat TCP4-LISTEN:8820,fork,su=nobody TCP6:[2604:1380:4642:a300::172]:8080 &
socat TCP4-LISTEN:32000,fork,su=nobody TCP6:[2604:1380:4642:a300::172]:30000 &
socat TCP4-LISTEN:32001,fork,su=nobody TCP6:[2604:1380:4642:a300::172]:30001 &
#
#c3sxda-tc21
socat TCP4-LISTEN:2221,fork,su=nobody TCP6:[2604:1380:4642:a300::1c2]:22 &
socat TCP4-LISTEN:8821,fork,su=nobody TCP6:[2604:1380:4642:a300::1c2]:8080 &
socat TCP4-LISTEN:32100,fork,su=nobody TCP6:[2604:1380:4642:a300::1c2]:30000 &
socat TCP4-LISTEN:32101,fork,su=nobody TCP6:[2604:1380:4642:a300::1c2]:30001 &
#
#c3sxda-tc22
socat TCP4-LISTEN:2222,fork,su=nobody TCP6:[2604:1380:4642:a300::182]:22 &
socat TCP4-LISTEN:8822,fork,su=nobody TCP6:[2604:1380:4642:a300::182]:8080 &
socat TCP4-LISTEN:32200,fork,su=nobody TCP6:[2604:1380:4642:a300::182]:30000 &
socat TCP4-LISTEN:32201,fork,su=nobody TCP6:[2604:1380:4642:a300::182]:30001 &
#
#c3sxda-tc23
socat TCP4-LISTEN:2223,fork,su=nobody TCP6:[2604:1380:4642:a300::1a2]:22 &
socat TCP4-LISTEN:8823,fork,su=nobody TCP6:[2604:1380:4642:a300::1a2]:8080 &
socat TCP4-LISTEN:32300,fork,su=nobody TCP6:[2604:1380:4642:a300::1a2]:30000 &
socat TCP4-LISTEN:32301,fork,su=nobody TCP6:[2604:1380:4642:a300::1a2]:30001 &
#
#c3sxda-tc24
socat TCP4-LISTEN:2224,fork,su=nobody TCP6:[2604:1380:4642:a300::1d2]:22 &
socat TCP4-LISTEN:8824,fork,su=nobody TCP6:[2604:1380:4642:a300::1d2]:8080 &
socat TCP4-LISTEN:32400,fork,su=nobody TCP6:[2604:1380:4642:a300::1d2]:30000 &
socat TCP4-LISTEN:32401,fork,su=nobody TCP6:[2604:1380:4642:a300::1d2]:30001 &
#
#c3sxda-tc25
socat TCP4-LISTEN:2225,fork,su=nobody TCP6:[2604:1380:4642:a300::192]:22 &
socat TCP4-LISTEN:8825,fork,su=nobody TCP6:[2604:1380:4642:a300::192]:8080 &
socat TCP4-LISTEN:32500,fork,su=nobody TCP6:[2604:1380:4642:a300::192]:30000 &
socat TCP4-LISTEN:32501,fork,su=nobody TCP6:[2604:1380:4642:a300::192]:30001 &
#
#c3sxda-tc26
socat TCP4-LISTEN:2226,fork,su=nobody TCP6:[2604:1380:4642:a300::1b2]:22 &
socat TCP4-LISTEN:8826,fork,su=nobody TCP6:[2604:1380:4642:a300::1b2]:8080 &
socat TCP4-LISTEN:32600,fork,su=nobody TCP6:[2604:1380:4642:a300::1b2]:30000 &
socat TCP4-LISTEN:32601,fork,su=nobody TCP6:[2604:1380:4642:a300::1b2]:30001 &
#
#c3sxda-tc27
socat TCP4-LISTEN:2227,fork,su=nobody TCP6:[2604:1380:4642:a300::1f2]:22 &
socat TCP4-LISTEN:8827,fork,su=nobody TCP6:[2604:1380:4642:a300::1f2]:8080 &
socat TCP4-LISTEN:32700,fork,su=nobody TCP6:[2604:1380:4642:a300::1f2]:30000 &
socat TCP4-LISTEN:32701,fork,su=nobody TCP6:[2604:1380:4642:a300::1f2]:30001 &
#
#c3sxda-tc28
socat TCP4-LISTEN:2228,fork,su=nobody TCP6:[2604:1380:4642:a300::1e2]:22 &
socat TCP4-LISTEN:8828,fork,su=nobody TCP6:[2604:1380:4642:a300::1e2]:8080 &
socat TCP4-LISTEN:32800,fork,su=nobody TCP6:[2604:1380:4642:a300::1e2]:30000 &
socat TCP4-LISTEN:32801,fork,su=nobody TCP6:[2604:1380:4642:a300::1e2]:30001 &
#
#c3sxda-tc29
socat TCP4-LISTEN:2229,fork,su=nobody TCP6:[2604:1380:4642:a300::202]:22 &
socat TCP4-LISTEN:8829,fork,su=nobody TCP6:[2604:1380:4642:a300::202]:8080 &
socat TCP4-LISTEN:32900,fork,su=nobody TCP6:[2604:1380:4642:a300::202]:30000 &
socat TCP4-LISTEN:32901,fork,su=nobody TCP6:[2604:1380:4642:a300::202]:30001 &
