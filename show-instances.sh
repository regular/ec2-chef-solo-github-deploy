#!/bin/bash

ec2-describe-instances --show-empty-fields|grep "INSTANCE"|awk '{ print $2,$6,$17}'