module gray_code #(
    parameter int WIDTH, // The width of the input you are converting to gray code
    parameter bit INVERT = 0 // Whether to invert the gray code, so you can degray
) (
    input logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);

logic [WIDTH-1:0] mapping [0:2**WIDTH-1];
logic [WIDTH-1:0] inverse_mapping [0:2**WIDTH-1];

if (INVERT)
    assign out = inverse_mapping[in];
else
    assign out = mapping[in];

generate
    genvar i, dimension;
    for (i = 0; i < 2**WIDTH; i++)
    begin: build_mapping
        for (dimension = 0; dimension < WIDTH; dimension++)
        begin
            if (i % 2**(dimension + 2) < 2**(dimension + 1))
                assign mapping[i][dimension] = i[dimension];
            else
                assign mapping[i][dimension] = !i[dimension];
        end
    end

    integer j;
    always_comb
    begin
        for (j = 0; j < 2**WIDTH; j++)
        begin
            if (in == mapping[j])
                inverse_mapping[in] = j;
        end
    end
    // for (i = 0; i < 2**WIDTH; i++)
    // begin: build_inverse_mapping
    //     assign inverse_mapping[mapping[i]] = WIDTH'(i);
    // end
endgenerate
    
endmodule