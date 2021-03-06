#!/bin/bash

task=sns
prefix_event=event
prefix_time=time

DATA_ROOT=$HOME/Research/NeuralPointProcess/data/real/$task
RESULT_ROOT=$HOME/scratch/results/NeuralPointProcess

gru=0
n_embed=32
H=256
h2=0
bptt=1
learning_rate=0.001
max_iter=4000
cur_iter=0
w_scale=0.001
time_scale=0.000001
lambda=6
unix_str=wHMmd
save_dir=$RESULT_ROOT/$net-$task-gru-$gru-hidden-$H-h2-$h2-embed-$n_embed-bptt-$bptt-bsize-$bsize

if [ ! -e $save_dir ];
then
    mkdir -p $save_dir
fi

dev_id=0

./build/main \
    -net $DATA_ROOT/links.txt \
    -gru $gru \
    -unix_str $unix_str \
    -h2 $h2 \
    -t_scale $time_scale \
    -event $DATA_ROOT/$prefix_event \
    -time $DATA_ROOT/$prefix_time \
    -lambda $lambda \
    -lr $learning_rate \
    -maxe $max_iter \
    -svdir $save_dir \
    -hidden $H \
    -embed $n_embed \
    -m 0.9 \
    -l2 0.01 \
    -w_scale $w_scale \
    -int_report 500 \
    -int_test 10000 \
    -int_save 10000 \
    -bptt $bptt \
    -cur_iter $cur_iter \
    2>&1 | tee $save_dir/log.txt
