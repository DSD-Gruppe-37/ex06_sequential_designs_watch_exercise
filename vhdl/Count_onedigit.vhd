LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
-----------------------------------------------------------------
ENTITY multi_counter IS
    PORT
    (
        --- Inputs
        clk   : IN std_logic;
        reset : IN std_logic;
        mode  : IN std_logic_vector(1 DOWNTO 0);
        --- Outputs
        count : OUT std_logic_vector(3 DOWNTO 0);
        cout  : OUT std_logic
    );
END ENTITY multi_counter;
-----------------------------------------------------------------
ARCHITECTURE ourCounter OF multi_counter IS

    --- Internal signals
    ---- counter - unsigned enables incremental operations
    SIGNAL intCount :
    unsigned(3 DOWNTO 0); --- 

BEGIN
    -- Start process
    PROCESS (clk, reset, mode, intCount)
        -- Updateable variable - enables modechange while counting...
        VARIABLE maxCount :
        unsigned(3 DOWNTO 0);

        -- Mode selector
    BEGIN
        CASE(mode) IS
            WHEN "00"   => maxCount   := "1001"; -- Count 0 to 9
            WHEN "01"   => maxCount   := "0101"; -- Count 0 to 5
            WHEN OTHERS => maxCount := "0010";   -- ELSE - Count 0 to 2
        END CASE;

        -- Clock triggering
        IF (rising_edge(clk)) THEN
            intCount <= intCount + 1;

            -- If count reaches max value
            IF (intCount = maxCount) THEN
                intCount <= (OTHERS => '0'); -- set all to 0
            END IF;

        END IF;

        -- Reset part
        IF (reset = '0') THEN        -- Active low
            intCount <= (OTHERS => '0'); -- set all to 0
        END IF;

        -- Carry output
        CASE(intCount) IS
            WHEN "0000" => cout <= '1';
            WHEN OTHERS => cout <= '0';
        END CASE;
        -- end the process - operation done.
    END PROCESS;
    -- casting back to std_logic_vector -- assign count value
    count <= std_logic_vector(intCount);

END ARCHITECTURE ourCounter;