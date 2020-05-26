CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE EXTENSION IF NOT EXISTS "postgis";

CREATE TABLE IF NOT EXISTS roadseg(
  acqtech VARCHAR(23) DEFAULT 'Unknown' CHECK (
    acqtech IN (
      'Unknown', 'None', 'Other', 'GPS', 'Orthoimage', 
      'Vector Data', 'Paper Map', 'Field Completion', 
      'Raster Data', 'Digital Elevation Model', 
      'Aerial Photo', 'Raw Imagery Data', 
      'Computed'
    )
  ) NOT NULL, 
  metacover VARCHAR(8) DEFAULT 'Unknown' CHECK (
    metacover IN ('Unknown', 'Complete', 'Partial')
  ) NOT NULL, 
  credate VARCHAR(8) DEFAULT REPLACE(to_char(now(),'YYYY-MM-DD'), '-', '') NOT NULL, 
  datasetnam VARCHAR(25) DEFAULT 'Alberta' CHECK (
    datasetnam IN (
      'Newfoundland and Labrador', 'Nova Scotia', 
      'Prince Edward Island', 'New Brunswick', 
      'Quebec', 'Ontario', 'Manitoba', 
      'Saskatchewan', 'Alberta', 'British Columbia', 
      'Yukon Territory', 'Northwest Territories', 
      'Nunavut'
    )
  ) NOT NULL, 
  accuracy NUMERIC(4, 0) DEFAULT -1 NOT NULL, 
  provider VARCHAR(24) DEFAULT 'Other' CHECK (
    provider IN (
      'Other', 'Federal', 'Provincial / Territorial', 
      'Municipal'
    )
  ) NOT NULL, 
  revdate VARCHAR(8) DEFAULT REPLACE(to_char(now(),'YYYY-MM-DD'), '-', '') NOT NULL, 
  specvers VARCHAR(10) DEFAULT '2.0' NOT NULL, 
  l_adddirfg VARCHAR(18) DEFAULT 'Same Direction' CHECK (
    l_adddirfg IN (
      'Same Direction', 'Opposite Direction', 
      'Not Applicable'
    )
  ) NOT NULL, 
  r_adddirfg VARCHAR(18) DEFAULT 'Same Direction' CHECK (
    r_adddirfg IN (
      'Same Direction', 'Opposite Direction', 
      'Not Applicable'
    )
  ) NOT NULL, 
  adrangenid VARCHAR(32) DEFAULT REPLACE(
    uuid_generate_v4()::text, 
    '-', 
    ''
  ) NOT NULL, 
  closing VARCHAR(32) DEFAULT 'Unknown' CHECK (
    closing IN (
      'Unknown', 'None', 'Summer', 'Winter'
    )
  ) NOT NULL, 
  exitnbr VARCHAR(32) DEFAULT 'None' NOT NULL, 
  l_hnumf VARCHAR(30) DEFAULT 'Unknown' NOT NULL, 
  r_hnumf VARCHAR(30) DEFAULT 'Unknown' NOT NULL, 
  roadclass VARCHAR(21) DEFAULT 'Freeway' CHECK (
    roadclass IN (
      'Freeway', 'Expressway / Highway', 
      'Arterial', 'Collector', 'Local / Street', 
      'Local / Strata', 'Local / Unknown', 
      'Alleyway / Lane', 'Ramp', 'Resource / Recreation', 
      'Rapid Transit', 'Service Lane', 
      'Winter'
    )
  ) NOT NULL, 
  l_hnuml VARCHAR(30) DEFAULT 'Unknown' NOT NULL, 
  r_hnuml VARCHAR(30) DEFAULT 'Unknown' NOT NULL, 
  nid VARCHAR(32) DEFAULT REPLACE(
    uuid_generate_v4():: text, 
    '-', 
    ''
  ) NOT NULL, 
  nbrlanes NUMERIC(4, 0) DEFAULT 1 NOT NULL, 
  l_placenam VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  r_placenam VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  l_stname_c VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  r_stname_c VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  pavsurf VARCHAR(8) DEFAULT 'Unknown' CHECK (
    pavsurf IN (
      'None', 'Summer', 
	  'Unknown', 'Winter', 'Blocks'
    )
  ) NOT NULL, 
  pavstatus VARCHAR(8) DEFAULT 'Unknown' CHECK (
    pavstatus IN (
		'Unknown', 'Paved', 'Unpaved')
  ) NOT NULL, 
  roadjuris VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  roadsegid SERIAL PRIMARY KEY NOT NULL, 
  rtename1en VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  rtename2en VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  rtename3en VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  rtename4en VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  rtename1fr VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  rtename2fr VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  rtename3fr VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  rtename4fr VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  rtnumber1 VARCHAR(10) DEFAULT 'Unknown' NOT NULL, 
  rtnumber2 VARCHAR(10) DEFAULT 'Unknown' NOT NULL, 
  rtnumber3 VARCHAR(10) DEFAULT 'Unknown' NOT NULL, 
  rtnumber4 VARCHAR(10) DEFAULT 'Unknown' NOT NULL, 
  rtnumber5 VARCHAR(10) DEFAULT 'Unknown' NOT NULL, 
  speed NUMERIC(4, 0) DEFAULT -1 NOT NULL, 
  strunameen VARCHAR(100) DEFAULT 'Uknown' NOT NULL, 
  strunamefr VARCHAR(100) DEFAULT 'Unknown' NOT NULL, 
  structid VARCHAR(32) DEFAULT  REPLACE(
    uuid_generate_v4():: text, 
    '-', 
    ''
  ) NOT NULL, 
  structtype VARCHAR(15) DEFAULT 'None' CHECK (
    structtype IN (
      'Bridge', 'Bridge covered', 'Bridge moveable', 
      'Bridge unknown', 'Tunnel', 'Snowshed', 
      'Dam', 'None'
    )
  ) NOT NULL, 
  trafficdir VARCHAR(18) DEFAULT 'Unknown' CHECK (
    trafficdir IN (
      'Both directions', 'Same direction', 
      'Opposite direction', 'Unknown'
    )
  ) NOT NULL, 
  unpavsurf VARCHAR(7) DEFAULT 'Unknown' CHECK (
    unpavsurf IN (
		'Unknown', 'None', 'Gravel', 'Dirt')
  ) NOT NULL
)

SELECT AddGeometryColumn('roadseg', 'geom', 4617, 'LineString', 2)