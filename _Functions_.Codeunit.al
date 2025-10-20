codeunit 50100 "Functions"
{
    internal procedure FindLastInvoicedPrice(BilltoCustomerNo: Code[20]; ItemNo: Code[20]): Decimal var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        SalesInvLine.SetRange("Bill-to Customer No.", BilltoCustomerNo);
        SalesInvLine.SetRange("No.", ItemNo);
        if SalesInvLine.FindLast()then exit(SalesInvLine."Unit Price");
    end;
    internal procedure FindLastQuote(SelltoCustomerNo: Code[20]; ItemNo: Code[20]): Code[20]var
        SalesQuoteLine: Record "Sales Line";
    begin
        SalesQuoteLine.SetRange("Sell-to Customer No.", SelltoCustomerNo);
        SalesQuoteLine.SetRange("No.", ItemNo);
        SalesQuoteLine.SetRange("Document Type", 0);
        if SalesQuoteLine.FindLast()then exit(SalesQuoteLine."Document No.");
    end;
    internal procedure FindQuoteExpiryDate(DocumentNo: Code[20]): Date var
        SalesQuote: Record "Sales Header";
    begin
        SalesQuote.SetRange("Document Type", 0);
        SalesQuote.SetRange("No.", DocumentNo);
        if SalesQuote.Find()then exit(SalesQuote."Quote Valid Until Date");
    end;
}
