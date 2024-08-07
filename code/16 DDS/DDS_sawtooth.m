ADDR_WIDTH = 12;
DATA_WIDTH = 8;
depth = 2^ADDR_WIDTH;
x = ceil( ( 2^DATA_WIDTH/2-1 ) * sawtooth( 0:pi*2/depth:2*pi ) + 2^DATA_WIDTH/2 );
fid = fopen('sawtoothrom1.mif', 'w');
fprintf(fid, 'width=%d;\n', DATA_WIDTH);
fprintf(fid, 'depth=%d;\n', depth);
fprintf(fid, 'address_radix=uns;\n');
fprintf(fid, 'data_radix=uns;\n');
fprintf(fid, 'Content Begin\n');
for i=1:depth
    fprintf(fid, '%d:%d;\n', i-1,x(i));
end
fprintf(fid, 'end;');