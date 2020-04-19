LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY multi_counter IS
    PORT (
        clk : IN std_logic;
        mode : IN std_logic_vector(1 DOWNTO 0);
        reset : IN std_logic; -- active low
        count : OUT std_logic_vector(3 DOWNTO 0);
        cout : OUT std_logic
    );
END ENTITY multi_counter;

ARCHITECTURE counter OF multi_counter IS
BEGIN
    PROCESS (clk, reset)
        VARIABLE maxValue : unsigned(3 DOWNTO 0)
        VARIABLE nextValue : unsigned(3 DOWNTO 0)
    BEGIN
        IF reset = '0' THEN
            -- reset the counter
            count <= "0000";
            cout <= '1';
        ELSIF rising_edge(clk) THEN
            -- set the maximum counter value
            CASE mode IS
                WHEN "00" => maxValue := to_unsigned(9, maxValue'length)
                WHEN "01" => maxValue := to_unsigned(5, maxValue'length)
                WHEN OTHERS => maxValue := to_unsigned(2, maxValue'length)
            END CASE;

            -- update counter
            nextValue := unsigned(count);
            IF (unsigned(count) + 1) >= maxValue THEN
                nextValue := (OTHERS => '0');
                cout <= '1';
            ELSE
                nextValue := nextValue + 1;
                count <= '0';
            END IF;

            count <= std_logic_vector(nextValue);
        END IF;
    END PROCESS;
END;