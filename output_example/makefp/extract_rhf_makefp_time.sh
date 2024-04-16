#!/bin/bash
 echo wall time '(s)'
 echo file_name, rhf, cphf, tdhf
 for i in *log; do
 # grep 'time rhf' for computational time of each rhf iteration
 # tot -> sum of all rhf iteration
 rhf=`grep 'time rhf' $i | awk  '{sum+=$5;} END{print sum;}' `
 cphf=`grep 'ts comment CPHFPOL' $i | awk  '{print $4}'`
 tdhf=`grep 'ts comment CPHFDYN' $i | awk  '{print $4}'`
 echo $i, $rhf, $cphf, $tdhf
 done
