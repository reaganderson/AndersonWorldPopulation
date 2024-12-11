# Check to see if countries not in the data will return an error
test_that('Countries not in data return error', {
  expect_error( CountryPopulation('Army'))
  expect_error( CountryPopulation('Washington'))
})
