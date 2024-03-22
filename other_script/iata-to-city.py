import json


location_dict = {}

def read_json(json_file):
    with open(json_file, 'r') as f:
        data = json.load(f)
        for airport in data:
            location_dict[airport['iata']] = airport
    return None


iata_list = ["SIN", "HKG", "LAX", "NRT", "SJC", "KIX", "ICN", "CDG",
             "FRA", "AMS", "TPE", "SYD", "BOM", "ARN", "LHR", "OSL",
             "IAD", "YYZ", "MXP", "YUL", "ORD", "CPH", "GRU", "MFM",
             "CPT", "SEA", "ATL", "IAH", "CGK", "DFW", "FCO", "MAD",
             "MRS", "PDX", "DUB", "MEL", "DEL", "DME", "BUF", "EWR",
             "KHH", "BUD", "ZRH", "MUC", "WAW", "VIE", "KUL", "BKK",
             "LOS", "MNL", "PHX", "MIA", "BNA", "MAN", "JIB", "DUR",
             "DEN", "PHL", "MSP", "DTW", "BOS", "LAS", "MCI", "SFO",
             "DXB", "JNB", "SMF", "TLH", "SCL", "PER", "VNO", "QRO",
             "HEL"]


city = read_json("../ipTest/locations.json")

for iata_code in iata_list: 
    ariaport = location_dict[iata_code]
    cityname = ariaport['city']
    contory = ariaport['cca2']
    print(f"{iata_code} : {cityname}")
