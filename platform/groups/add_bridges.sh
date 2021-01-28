#!/bin/bash
ovs-vsctl -- add-br 1-host -- add-br 2-host -- add-br l2-1 -- add-br l2-2 -- add-br int-1 -- add-br int-2 -- add-br ext-0 