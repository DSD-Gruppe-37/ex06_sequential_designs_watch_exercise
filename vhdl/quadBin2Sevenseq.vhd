LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY quadBin2Sevenseq IS
    PORT
    (
        -- inputs
        bin    : IN std_logic_vector(15 DOWNTO 0);
        -- outputs
        min_1  : OUT std_logic_vector(6 DOWNTO 0);
        min_10 : OUT std_logic_vector(6 DOWNTO 0);
        hrs_1  : OUT std_logic_vector(6 DOWNTO 0);
        hrs_10 : OUT std_logic_vector(6 DOWNTO 0)
    );
END ENTITY quadBin2Sevenseq;

ARCHITECTURE rtl OF quadBin2Sevenseq IS

BEGIN
    --- minutes
    -- display ones
    HexdisplayMinOnes : ENTITY bin2hex
        PORT MAP
        (
            bin  => bin(3 DOWNTO 0),
            sseg => min_1
        );
    -- diplay tens

    HexdisplayMinTens : ENTITY bin2hex
        PORT
        MAP
        (
        bin  => bin(7 DOWNTO 4),
        sseg => min_10
        );
    --- Hours
    -- display ones
    HexdisplayHoursOnes : ENTITY bin2hex
        PORT
        MAP
        (
        bin  => bin(11 DOWNTO 8),
        sseg => hrs_1
        );
    -- diplay tens
    HexdisplayHoursTens : ENTITY bin2hex
        PORT
        MAP
        (
        bin  => bin(15 DOWNTO 12),
        sseg => hrs_10
        );
END ARCHITECTURE rtl;