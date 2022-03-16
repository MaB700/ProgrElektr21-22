library ieee;
use ieee.std_logic_1164.all;

entity display_wrapper is
    port (
        CLK    :  in std_logic;
        BINARY :  in std_logic_vector(13 downto 0);
        SEG    : out std_logic_vector(6 downto 0);
        DP     : out std_logic;
        AN     : out std_logic_vector(3 downto 0)
    );
end entity display_wrapper;

architecture wrapper of display_wrapper is
    component display
        port (
            CLK    :  in std_logic;
            BINARY :  in std_logic_vector(13 downto 0);
            SEG    : out std_logic_vector(6 downto 0);
            DP     : out std_logic;
            AN     : out std_logic_vector(3 downto 0)
        );
    end component display;
begin
    display_i : display
    port map (
        CLK    => CLK,
        BINARY => BINARY,
        SEG    => SEG,
        DP     => DP,
        AN     => AN
    );
end architecture wrapper;
