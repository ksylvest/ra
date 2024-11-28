# Ra

[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ksylvest/ra/blob/main/LICENSE)
[![RubyGems](https://img.shields.io/gem/v/ra)](https://rubygems.org/gems/ra)
[![GitHub](https://img.shields.io/badge/github-repo-blue.svg)](https://github.com/ksylvest/ra)
[![Yard](https://img.shields.io/badge/docs-site-blue.svg)](https://ra.ksylvest.com)
[![CircleCI](https://img.shields.io/circleci/build/github/ksylvest/ra)](https://circleci.com/gh/ksylvest/ra)
[![Code Climate Maintainability](https://img.shields.io/codeclimate/maintainability/ksylvest/ra)](https://codeclimate.com/github/ksylvest/ra)
[![Code Climate Coverage](https://img.shields.io/codeclimate/coverage/ksylvest/ra)](https://codeclimate.com/github/ksylvest/ra)

Named for [Ra](https://en.wikipedia.org/wiki/Ra) - arguably the original ray tracer.

## Installation

```sh
gem install ra
```

## Usage

```sh
ra -w 2560 -h 2048 > sample.ppm
convert -quality 80 sample.ppm sample.avif
```

![Sample](https://github.com/ksylvest/ra/raw/main/sample.avif)
