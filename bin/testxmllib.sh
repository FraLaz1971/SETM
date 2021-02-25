#!/bin/bash
#this script tests the functionality of the bash xml lib
. lib/xml_lib
putDeclaration
openTag "HK"
openTag "HKsample"; 
  openTag "Time"
    echo 0; 
  closeTag "Time"
  openTag "Temp1"
    echo 1; 
  closeTag "Temp1"
  openTag "Temp2"
    echo 2;
  closeTag "Temp2"
closeTag "HKsample"

openTag "HKsample"; 
  openTag "Time"
    echo 10; 
  closeTag "Time"
  openTag "Temp1"
    echo 11; 
  closeTag "Temp1"
  openTag "Temp2"
    echo 12; 
  closeTag "Temp2"
closeTag "HKsample"
openTag "HKsample"; 
  openTag "Time"
    echo 20; 
  closeTag "Time"
  openTag "Temp1"
    echo 21; 
  closeTag "Temp1"
  openTag "Temp2"
    echo 22; 
  closeTag "Temp2"
closeTag "HKsample"
autoTag "BR"
closeTag "HK"
