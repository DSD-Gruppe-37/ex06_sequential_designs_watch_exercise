LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
-----------------------------------------------------------------
ENTITY Count_onedigit IS
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
END ENTITY Count_onedigit;
-----------------------------------------------------------------
ARCHITECTURE ourCounter OF Count_onedigit IS

    --- Interne signaler
    ---- counter
    SIGNAL intCount :
    unsigned(3 DOWNTO 0); --- 
    ---- max value / reset point

BEGIN
    PROCESS (clk, reset, mode, intCount)

        VARIABLE maxCount :
        unsigned(3 DOWNTO 0);

    BEGIN
        CASE(mode) IS
            WHEN "00"   => maxCount   := "1001";
            WHEN "01"   => maxCount   := "0101";
            WHEN OTHERS => maxCount := "0010";
            -- IF (mode = "00") THEN
            --     maxCount := "1001";
            -- ELSIF (mode = "01") THEN
            --     maxCount := "0101";
            -- ELSE
            --     maxCount := "0010";
            -- END IF;
        END CASE;

        IF (rising_edge(clk)) THEN
            intCount <= intCount + 1;
            IF (intCount = maxCount) THEN
                intCount <= (OTHERS => '0'); -- set all to 0
            END IF;
        END IF;

        IF (reset = '0') THEN
            intCount <= (OTHERS => '0');
        END IF;

    END PROCESS;
    -- casting tilbage til std_logic_vector
    count <= std_logic_vector(intCount);

    PROCESS (intCount)
    BEGIN
        CASE(intCount) IS
            WHEN "0000" => cout <= '1';
            WHEN OTHERS => cout <= '0';
        END CASE;
    END PROCESS;

END ARCHITECTURE ourCounter;