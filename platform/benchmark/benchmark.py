#!/usr/bin/env python3

import os
import re
import shutil
import time

ben_file=''
asn_li = []

as_ori = 'AS_config.txt'
el_ori= 'external_links_config.txt'

def getConfig(configDir):
    asn_li=[]
    for parent, dirnames, filenames in os.walk(configDir):
        for file in filenames:
            if 'AS' in file:
                asn = re.sub(r'[^0-9]', '', file)
                asn_li.append(int(asn))
    asn_li.sort()
    return asn_li

def copyfile(src, dest):
    if os.path.exists(dest):
        os.remove(dest)
    
    # move startup file
    try:
        shutil.copy(src,dest)
    except IOError as e:
        print("Unable to copy file. %s" % e)
    except:
        print("Unexpected error:", sys.exc_info())

def copyconfig(asn):
    asc = 'AS_config_' + str(asn) + '.txt'
    elc = 'external_links_config_' + str(asn) + '.txt'

    copyfile('benchmark/config/{}'.format(asc), 'config/{}'.format(as_ori))
    copyfile('benchmark/config/{}'.format(elc),'config/{}'.format(el_ori))
    

def choice():
    global ben_file
    mode = input("""==== iSula mini-internet Benchmark ====


请选择要进行的测试类型:
    1. 全量测试(每次测试安装全部内容)
    2. 轻量测试(每次测试只安装容器)
输入选项(1/2):""")

    if mode == '1':
        ben_file = 'startup_ben_full.sh'
    elif mode == '2':
        ben_file = 'startup_ben_lite.sh'
    else:
        print('未能识别，退出测试')
        exit(1)

def beforeTest():
    global ben_file,as_ori,el_ori,asn_li
    ## get choice
    choice()

    if os.path.exists('./{}'.format(ben_file)):
        os.remove('./{}'.format(ben_file))
    
    # copy startup file
    copyfile('benchmark/{}'.format(ben_file),'./{}'.format(ben_file))

    # get config id
    asn_li = getConfig('benchmark/config/')
    
    # save origin config
    copyfile('config/{}'.format(as_ori),'config/{}.bak'.format(as_ori))
    copyfile('config/{}'.format(el_ori),'config/{}.bak'.format(el_ori))


def afterTest():
    global ben_file,as_ori,el_ori,asn_li
    # restore config
    copyfile('config/{}.bak'.format(as_ori),'config/{}'.format(as_ori))
    copyfile('config/{}.bak'.format(el_ori), 'config/{}'.format(el_ori))
    os.remove('config/{}.bak'.format(as_ori))
    os.remove('config/{}.bak'.format(el_ori))


def startTest():
    global ben_file, as_ori, el_ori,asn_li
    
    for asn in asn_li:
        copyconfig(asn)

        cmd = 'sudo bash %s %d' % (ben_file, asn)
        print('即将执行：' + cmd)
        time.sleep(3)
        
        os.system(cmd)
        
        time.sleep(5)
    


os.chdir('../')
beforeTest()
startTest()
afterTest()



