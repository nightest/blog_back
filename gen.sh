#!/bin/bash

hexo clean
hexo g
hexo deploy
git add .
git commit -m 'add posts'
git push coding master:master
