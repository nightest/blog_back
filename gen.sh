#!/bin/bash

hexo clean
hexo g
hexo deploy
git pull coding master
git add .
git commit -m 'add posts'
git push coding master:master
