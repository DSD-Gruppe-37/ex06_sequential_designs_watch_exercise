LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;
ENTITY watch IS
    PORT
    (
        --inputs
        clk    : IN std_logic;
        reset  : IN std_logic;
        speed  : IN std_logic;
        -- outputs
        sec_1  : OUT std_logic_vector(6 DOWNTO 0);
        sec_10 : OUT std_logic_vector(6 DOWNTO 0);
        min_1  : OUT std_logic_vector(6 DOWNTO 0);
        min_10 : OUT std_logic_vector(6 DOWNTO 0);
        hrs_1  : OUT std_logic_vector(6 DOWNTO 0);
        hrs_10 : OUT std_logic_vector(6 DOWNTO 0);
        tm     : OUT std_logic_vector(15 DOWNTO 8)
    );
END ENTITY watch;

ARCHITECTURE rtl OF watch IS
    SIGNAL secCarry        : std_logic;
    SIGNAL minCarry        : std_logic;
    SIGNAL ClkOut_internal : std_logic;
BEGIN
    --- Main clock generator:
    ClockGenerator : ENTITY clock_gen
        PORT MAP
        (
            clk     => clk,
            reset   => reset,
            speed   => speed,
            clk_Out => ClkOut_internal
        );

    --- Seconds section

    DualSecCounter : ENTITY TwoCounters
        PORT
        MAP
        (
        clkIn                  => ClkOut_internal,
        resetIn                => reset,
        modeOnes(1 DOWNTO 0)   => "00",
        modeTens(1 DOWNTO 0)   => "01",
        coutOut                => secCarry,
        segOnesOut(6 DOWNTO 0) => sec_1(6 DOWNTO 0),
        segTensOut(6 DOWNTO 0) => sec_10(6 DOWNTO 0)
        );

    --- Minutes section

    DualMinCounter : ENTITY TwoCounters
        PORT
        MAP
        (
        clkIn                  => secCarry,
        resetIn                => reset,
        modeOnes(1 DOWNTO 0)   => "00",
        modeTens(1 DOWNTO 0)   => "01",
        coutOut                => minCarry,
        segOnesOut(6 DOWNTO 0) => min_1(6 DOWNTO 0),
        segTensOut(6 DOWNTO 0) => min_10(6 DOWNTO 0)
        );

    --- Hrs section

    DualHrsCounter : ENTITY TwoCounters
        PORT
        MAP
        (
        clkIn                  => minCarry,
        resetIn                => reset,
        modeOnes(1 DOWNTO 0)   => "00",
        modeTens(1 DOWNTO 0)   => "11",
        coutOut                => OPEN,
        segOnesOut(6 DOWNTO 0) => hrs_1(6 DOWNTO 0),
        segTensOut(6 DOWNTO 0) => hrs_10(6 DOWNTO 0)
        );
END ARCHITECTURE rtl;