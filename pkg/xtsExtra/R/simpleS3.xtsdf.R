#   xtsExtra: Extensions to xts during GSOC-2012
#
#   Copyright (C) 2012  Michael Weylandt: michael.weylandt@gmail.com
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.


## A collection of simple but useful S3 generics

index.xtsdf <- function(x, ...) index(x[[1]], ...)

time.xtsdf <- index.xtsdf

`index<-.xtsdf` <- function(x, value) {
  for(i in seq_along(x)){
    index(x[[i]]) <- value
  }
  x
}

`time<-.xtsdf` <- `index<-.xtsdf`

as.list.xtsdf <- function(x, ...) unclass(x)

dim.xtsdf <- function(x) c(length(x[[1]]), length(x))

dimnames.xtsdf <- function(x) list(index(x), names(x))

as.zoo.xtsdf <- function(x, ...) as.zoo(as.xts(x, ...), ...)

indexTZ.xtsdf <- function(x, ...) indexTZ(x[[1]])

`indexTZ<-.xtsdf` <- function(x, value) {
  for(i in seq_along(x)){
    indexTZ(x[[i]]) <- value
  }
  x
}

lag.xtsdf <- function(x, k = 1, na.pad = TRUE, ...) {
  ans <- lapply(x, lag, k = 1, na.pad = TRUE, ...)
  class(ans) <- "xtsdf"
  ans
}

summary.xtsdf <- function(object, ...) summary(cbind(index = index(object), 
                                                     as.data.frame(object)), ...)

head.xtsdf <- utils:::head.data.frame
tail.xtsdf <- utils:::tail.data.frame

coredata.xtsdf <- function(x, ...) as.data.frame(x)

#### NEED TO MAKE INDEX CLASS A S3 GENERIC FOR NOW

indexClass <- function(x) UseMethod("indexClass")

indexClass.xts <- xts::indexClass

indexClass.xtsdf <- function(x) indexClass(x[[1]])

`indexClass<-.xtsdf` <- function(x, value){
  for(i in seq_along(x)){
    indexClass(x[[i]]) <- value
  }
}