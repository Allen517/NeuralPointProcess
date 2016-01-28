#include <iostream>
#include <fstream>
#include <cstdio>
#include <vector>
#include <algorithm>
#include <cstring>
#include <cmath>
#include "time_net.h"
#include "config.h"
#include "data_loader.h"
#include "real_data_loader.h"

template<MatMode mode>
void Work()
{
    TimeNet<mode, Dtype>* net = new TimeNet<mode, Dtype>();
    net->Setup();
    net->MainLoop();
}

int main(const int argc, const char** argv)
{
    cfg::LoadParams(argc, argv);    
	GPUHandle::Init(cfg::dev_id);
    
    LoadRealData();
    
    if (cfg::device_type == CPU)
        Work<CPU>();
    else
        Work<GPU>();     
    GPUHandle::Destroy();
    return 0;
}