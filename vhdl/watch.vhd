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
        tm     : OUT std_logic_vector(15 DOWNTO 0)
    );
END ENTITY watch;

ARCHITECTURE rtl OF watch IS
    SIGNAL secCarry        : std_logic;
    SIGNAL minCarry        : std_logic;
    SIGNAL ResetSignal     : std_logic;
    SIGNAL minBinOnes      : std_logic_vector(3 DOWNTO 0);
    SIGNAL minBinTens      : std_logic_vector(3 DOWNTO 0);
    SIGNAL hrsBinOnes      : std_logic_vector(3 DOWNTO 0);
    SIGNAL hrsBinTens      : std_logic_vector(3 DOWNTO 0);
    SIGNAL ClkOut_internal : std_logic;
BEGIN

    --- Main clock:
    ClockGenerator : ENTITY clock_gen
        PORT MAP
        (
            clk     => clk,
            reset   => ResetSignal,
            speed   => speed,
            clk_Out => ClkOut_internal
        );

    --- Seconds counter
    DualSecCounter : ENTITY TwoCounters
        PORT
        MAP
        (
        clkIn      => ClkOut_internal,
        resetIn    => ResetSignal,
        modeOnes   => "00",
        modeTens   => "01",
        coutOut    => secCarry,
        segOnesOut => sec_1,
        segTensOut => sec_10,
        countOnes  => OPEN,
        countTens  => OPEN
        );

    --- Minutes counter
    DualMinCounter : ENTITY TwoCounters
        PORT
        MAP
        (
        clkIn      => secCarry,
        resetIn    => ResetSignal,
        modeOnes   => "00",
        modeTens   => "01",
        coutOut    => minCarry,
        segOnesOut => min_1,
        segTensOut => min_10,
        countOnes  => minBinOnes,
        countTens  => minBinTens

        );

    --- Hrs counter
    DualHrsCounter : ENTITY TwoCounters
        PORT
        MAP
        (
        clkIn      => minCarry,
        resetIn    => ResetSignal,
        modeOnes   => "00",
        modeTens   => "11",
        coutOut    => OPEN,
        segOnesOut => hrs_1,
        segTensOut => hrs_10,
        countOnes  => hrsBinOnes,
        countTens  => hrsBinTens
        );

    --- reset logic
    ResetLogic : ENTITY reset_logic
        PORT
        MAP(
        -- input
        reset_in  => reset,
        hrs_bin1  => hrsBinOnes,
        hrs_bin10 => hrsBinTens,
        -- output
        reset_out => ResetSignal
        );

    --- tm section
    tm <= (hrsBinTens & hrsBinOnes & minBinTens & minBinOnes);
END ARCHITECTURE rtl;