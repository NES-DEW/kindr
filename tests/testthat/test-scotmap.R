is_sf <- function(x) {
  a <- attributes(x)
  all( a$class == c("sf","tbl_df","tbl","data.frame") ) & a$sf_column == "geom"
}

test_that("Default function", {
  expect_equal(is_sf(scotmap()), TRUE)
})

test_that("Default function", {
  expect_equal(nrow(scotmap()), 6976)
})

test_that("DZ", {
  expect_equal(is_sf(scotmap("DZ")), TRUE)
})

test_that("DZ", {
  expect_equal(nrow(scotmap("DZ")), 6976)
})

test_that("DZ single code", {
  expect_equal(is_sf(scotmap("DZ", "code", "S01006508")), TRUE)
})

test_that("DZ single code n", {
  expect_equal(nrow(scotmap("DZ", "code", "S01006508")), 1)
})

test_that("DZ multiple code", {
  expect_equal(is_sf(scotmap("DZ", "code", c("S01006508", "S01006509"))), TRUE)
})

test_that("DZ multiple code n", {
  expect_equal(nrow(scotmap("DZ", "code", c("S01006508", "S01006509"))), 2)
})

test_that("DZ single name", {
  expect_equal(is_sf(scotmap("DZ", "name", "Culter")), TRUE)
})

test_that("DZ single name n", {
  expect_equal(nrow(scotmap("DZ", "name", "Culter")), 7)
})

test_that("DZ single name lowercase", {
  expect_equal(is_sf(scotmap("DZ", "name", "culter")), TRUE)
})

test_that("DZ single name lowercase n", {
  expect_equal(nrow(scotmap("DZ", "name", "culter")), 7)
})

test_that("DZ multiple name", {
  expect_equal(is_sf(scotmap("DZ", "name", c("cults", "culter"))), TRUE)
})

test_that("DZ multiple name n", {
  expect_equal(nrow(scotmap("DZ", "name", c("cults", "culter"))), 21)
})

test_that("HB", {
  expect_equal(is_sf(scotmap("HB")), TRUE)
})

test_that("HB n", {
  expect_equal(nrow(scotmap("HB")), 14)
})
scotmap("HB")
test_that("HB single code", {
  expect_equal(is_sf(scotmap("HB", "code", "S08000022")), TRUE)
})

test_that("HB single code n", {
  expect_equal(nrow(scotmap("HB", "code", "S08000022")), 1)
})

test_that("HB multiple code", {
  expect_equal(is_sf(scotmap("HB", "code", c("S08000020", "S08000022"))), TRUE)
})

test_that("HB multiple code n", {
  expect_equal(nrow(scotmap("HB", "code", c("S08000020", "S08000022"))), 2)
})

test_that("HB single name", {
  expect_equal(is_sf(scotmap("HB", "name", "high")), TRUE)
})

test_that("HB single name n", {
  expect_equal(nrow(scotmap("HB", "name", "high")), 1)
})

test_that("HB multiple name", {
  expect_equal(is_sf(scotmap("HB", "name", c("high", "gramp"))), TRUE)
})

test_that("HB multiple name n", {
  expect_equal(nrow(scotmap("HB", "name", c("high", "gramp"))), 2)
})

test_that("IZ", {
  expect_equal(is_sf(scotmap("IZ")), TRUE)
})

test_that("IZ n", {
  expect_equal(nrow(scotmap("IZ")), 1279)
})

test_that("IZ single code", {
  expect_equal(is_sf(scotmap("IZ", "code", "S02001245")), TRUE)
})

test_that("IZ single code n", {
  expect_equal(nrow(scotmap("IZ", "code", "S02001245")), 1)
})

test_that("IZ multiple code", {
  expect_equal(is_sf(scotmap("IZ", "code", c("S02001245", "S02001239"))), TRUE)
})

test_that("IZ multiple code n", {
  expect_equal(nrow(scotmap("IZ", "code", c("S02001245", "S02001239"))), 2)
})

test_that("IZ single name", {
  expect_equal(is_sf(scotmap("IZ", "name", "Hazlehead")), TRUE)
})

test_that("IZ single name n", {
  expect_equal(nrow(scotmap("IZ", "name", "Hazlehead")), 1)
})

test_that("IZ multiple name", {
  expect_equal(is_sf(scotmap("IZ", "name", c("Hazlehead", "West End north"))), TRUE)
})

test_that("IZ multiple name n", {
  expect_equal(nrow(scotmap("IZ", "name", c("Hazlehead", "West End north"))), 2)
})

test_that("HIA", {
  expect_equal(is_sf(scotmap("HIA")), TRUE)
})

test_that("HIA n", {
  expect_equal(nrow(scotmap("HIA")), 31)
})

test_that("HIA single code", {
  expect_equal(is_sf(scotmap("HIA", "code", "S37000016")), TRUE)
})

test_that("HIA single code n", {
  expect_equal(nrow(scotmap("HIA", "code", "S37000016")), 1)
})

test_that("HIA multiple code", {
  expect_equal(is_sf(scotmap("HIA", "code", c("S37000016", "S37000017"))), TRUE)
})

test_that("HIA multiple code n", {
  expect_equal(nrow(scotmap("HIA", "code", c("S37000016", "S37000017"))), 2)
})

test_that("HIA single name", {
  expect_equal(is_sf(scotmap("HIA", "name", "Highland")), TRUE)
})

test_that("HIA single name n", {
  expect_equal(nrow(scotmap("HIA", "name", "Highland")), 1)
})

test_that("HIA multiple name", {
  expect_equal(is_sf(scotmap("HIA", "name", c("Highland", "falki"))), TRUE)
})

test_that("HIA multiple name n", {
  expect_equal(nrow(scotmap("HIA", "name", c("Highland", "falki"))), 2)
})
