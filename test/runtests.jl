using SPICE
using Base.Test
using BinDeps

const LSK_URL = "http://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/"
const LSK_FILE = "naif0012.tls"
const SPK_URL = "http://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/"
const SPK_FILE = "de430.bsp"

if !isfile(LSK_FILE)
    run(download_cmd(LSK_URL*LSK_FILE, LSK_FILE))
end
if !isfile(SPK_FILE)
    run(download_cmd(SPK_URL*SPK_FILE, SPK_FILE))
end

furnsh([SPK_FILE, LSK_FILE])

datestring0 = Dates.format(now(), "yyyy-mm-ddTHH:MM:SS")
et = str2et(datestring0)
datestring1 = timout(et,"YYYY-MM-DDTHR:MN:SC")
@test datestring1 == datestring0
@test_throws ErrorException timout(et,"")

unload([SPK_FILE, LSK_FILE])

try
    handle = spkopn("test.spk", "SPK_test", 0)
    spkcls(handle)
finally
    isfile("test.spk") && rm("test.spk")
end
