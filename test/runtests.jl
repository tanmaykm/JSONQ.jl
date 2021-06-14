using Test
using JSONQ
using JSON3

@testset "JSONQ" begin
    maths_test_dataset_file = joinpath(@__DIR__, "sample_math_test_results.json")
    maths_test_dataset_url = "https://data.cityofnewyork.us/api/views/7yig-nj52/rows.json?accessType=DOWNLOAD"
    isfile(maths_test_dataset_file) || download(maths_test_dataset_url, maths_test_dataset_file)
    maths_test_dataset = JSON3.read(read(maths_test_dataset_file, String))

    ctx = JSONQ.Ctx()
    JSONQ.compile(ctx, ".meta.view.attributionLink"; name="attr")
    JSONQ.compile(ctx, ".meta.view.columns[1].name"; name="col1name")

    @test JSONQ.execute(ctx, maths_test_dataset, "attr") == "http://schools.nyc.gov/NR/rdonlyres/3E439D63-A14E-4B6E-B019-B634A8915D71/0/DistrictMathResults20062012Public.xlsx"
    @test JSONQ.execute(ctx, maths_test_dataset, "col1name") == "sid"
end