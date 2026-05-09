-- Initial Setup Migration
-- Enable required extensions

-- Enable UUID extension for generating UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enable PostGIS extension for geospatial data
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Create updated_at trigger function
-- This function automatically updates the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Comment on function
COMMENT ON FUNCTION update_updated_at_column() IS 'Automatically updates the updated_at column on row update';
