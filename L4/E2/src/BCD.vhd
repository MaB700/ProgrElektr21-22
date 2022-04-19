library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity BCD is
    port (
        BIN : in std_logic_vector(13 downto 0);
        BCD : out std_logic_vector(15 downto 0);
        VALID : out std_logic
    );
end BCD;

architecture Behavioral of BCD is
    signal bcd_out : std_logic_vector(4 * 4 - 1 downto 0);
begin
    VALID <= '0' when unsigned(BIN) > 9999 else
             '1';
    -- ''double dabble'' algorithm
    process (BIN) is -- is calculated each time BIN changes
        variable comb : unsigned(4 * 4 + 14 - 1 downto 0); -- BCD & BIN combined
    begin
        comb(13 downto 0) := unsigned(BIN);
        comb(29 downto 14) := (others => '0');
        for i in 13 downto 0 loop

            for j in 3 downto 0 loop -- 2 a) loop
                if comb(j * 4 + 3 + 14 downto j * 4 + 14) > 4 then
                    comb(j * 4 + 3 + 14 downto j * 4 + 14) := comb(j * 4 + 3 + 14 downto j * 4 + 14) + 3;
                end if;
            end loop;

            for k in 4 * 4 + 14 - 1 downto 1 loop -- 2 b) loop
                comb(k) := comb(k - 1);
            end loop;
            comb(0) := '0';

        end loop;
        bcd_out <= std_logic_vector(comb(29 downto 14));
    end process;
    BCD <= std_logic_vector(bcd_out);
end Behavioral;