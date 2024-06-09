
#Create simulator 
set ns [new Simulator] 
set tracefile [open lab1.tr w] 
$ns trace-all $tracefile 
set namfile [open lab1.nam w] 
$ns namtrace-all $namfile 
#create node 
set n0 [$ns node] 
set n1 [$ns node] 
set n2 [$ns node] 
#create link 
$ns duplex-link $n0 $n1 2Mb 10ms 
DropTail 
$ns duplex-link $n1 $n2 0.5Mb 10ms 
DropTail 
#Set Queue Size 
$ns queue-limit $n0 $n1 05 
$ns queue-limit $n1 $n2 05 
#setup tcp connection 
set tcp [new Agent/TCP] 
$ns attach-agent $n0 $tcp 
#set sink to node 
set sink [new Agent/TCPSink] 
$ns attach-agent $n2 $sink 
Computer Networks Lab 
22MCAL17 
#connect tcp src and sink 
$ns connect $tcp $sink 
set ftp [new Application/FTP] 
$ftp attach-agent $tcp 
$ftp set packetSize_ 1024 
proc finish {} { 
global ns tracefile namfile 
$ns flush-trace 
close $tracefile
