#!/bin/bash
 echo max_time from rhf iteration, '(s)'
 for i in *log; do
 # grep 'time rhf' for computational time of each rhf iteration
 grep 'time rhf' $i | awk '{print $5}'  > temp
 # tail -n +2 temp ->  discard the first iteration to avoid GPU warm-up and JIT time
 # sort -n | tail -n 1 -> extract max_value
 maxtime=`tail -n +2 temp | sort -n | tail -n 1`
 echo $i, $maxtime
 done
 rm temp
 echo wall time for rhf, '(s)'
 for i in *log; do
 # grep 'time rhf' for computational time of each rhf iteration
 # tot -> sum of all rhf iteration
 tot=`grep 'time rhf' $i | awk  '{sum+=$5;} END{print sum;}' `
 echo $i, $tot
 done
