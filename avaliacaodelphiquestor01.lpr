program avaliacaodelphiquestor01; // programa

{$mode objfpc}{$H+}

uses
  SysUtils;

type
  TCliente = class
  private
    FCodigoCliente: Integer;
    FNomeCliente: string;
    FCpfCliente: string;
  public
    constructor Create(ACodigoCliente: Integer; ANomeCliente, ACpfCliente: string);
    procedure Inserir;
    property CodigoCliente: Integer read FCodigoCliente;
    property NomeCliente: string read FNomeCliente;
    property CpfCliente: string read FCpfCliente;
  end;

  TCarro = class
  private
    FCodigoCarro: Integer;
    FModelo: string;
    FDataLancamento: TDate;
  public
    constructor Create(ACodigoCarro: Integer; AModelo: string; ADataLancamento: TDate);
    procedure Inserir;
    property CodigoCarro: Integer read FCodigoCarro;
    property Modelo: string read FModelo;
    property DataLancamento: TDate read FDataLancamento;
  end;

  TVenda = class
  private
    FCodigoVenda: Integer;
    FCodigoCliente: Integer;
    FCodigoCarro: Integer;
    FDataVenda: TDate;
    FValor: Currency;
  public
    constructor Create(ACodigoVenda, ACodigoCliente, ACodigoCarro: Integer;
      ADataVenda: TDate; AValor: Currency);
    procedure Inserir;
    property CodigoVenda: Integer read FCodigoVenda;
    property CodigoCliente: Integer read FCodigoCliente;
    property CodigoCarro: Integer read FCodigoCarro;
    property DataVenda: TDate read FDataVenda;
    property Valor: Currency read FValor;
  end;

procedure InserirDadosBD(const ASQL: string);
begin
  Writeln('[InserirDadosBD] ' + ASQL);
end;

procedure ExecutarSql(const ASQL: string);
begin
  Writeln('[ExecutarSql] ' + ASQL);
end;

constructor TCliente.Create(ACodigoCliente: Integer; ANomeCliente, ACpfCliente: string);
begin
  FCodigoCliente := ACodigoCliente;
  FNomeCliente   := ANomeCliente;
  FCpfCliente    := ACpfCliente;
end;

procedure TCliente.Inserir;
begin
  InserirDadosBD(
    'INSERT INTO CLIENTES (CODIGOCLIENTE, NOMECLIENTE, CPFCLIENTE) VALUES (' +
    IntToStr(FCodigoCliente) + ', ' +
    QuotedStr(FNomeCliente) + ', ' +
    QuotedStr(FCpfCliente) + ')'
  );
end;

constructor TCarro.Create(ACodigoCarro: Integer; AModelo: string; ADataLancamento: TDate);
begin
  FCodigoCarro    := ACodigoCarro;
  FModelo         := AModelo;
  FDataLancamento := ADataLancamento;
end;

procedure TCarro.Inserir;
begin
  InserirDadosBD(
    'INSERT INTO CARRO (CODIGOCARRO, MODELO, DATALANCAMENTO) VALUES (' +
    IntToStr(FCodigoCarro) + ', ' +
    QuotedStr(FModelo) + ', ' +
    QuotedStr(DateToStr(FDataLancamento)) + ')'
  );
end;

constructor TVenda.Create(ACodigoVenda, ACodigoCliente, ACodigoCarro: Integer;
  ADataVenda: TDate; AValor: Currency);
begin
  FCodigoVenda   := ACodigoVenda;
  FCodigoCliente := ACodigoCliente;
  FCodigoCarro   := ACodigoCarro;
  FDataVenda     := ADataVenda;
  FValor         := AValor;
end;

procedure TVenda.Inserir;
begin
  InserirDadosBD(
    'INSERT INTO VENDA (CODIGOVENDA, CODIGOCLIENTE, CODIGOCARRO, DATAVENDA, VALOR) VALUES (' +
    IntToStr(FCodigoVenda) + ', ' +
    IntToStr(FCodigoCliente) + ', ' +
    IntToStr(FCodigoCarro) + ', ' +
    QuotedStr(DateToStr(FDataVenda)) + ', ' +
    CurrToStr(FValor) + ')'
  );
end;

var
  Clientes: array[1..5] of TCliente;
  Carros:   array[1..5] of TCarro;
  Vendas:   array[1..5] of TVenda;
  I: Integer;

begin
  // clientes
  Clientes[1] := TCliente.Create(1, 'Ana Oliveira',   '01234567890');
  Clientes[2] := TCliente.Create(2, 'Bruno Silva',    '12345678901');
  Clientes[3] := TCliente.Create(3, 'Carlos Souza',   '09876543210');
  Clientes[4] := TCliente.Create(4, 'Diana Costa',    '00011122233');
  Clientes[5] := TCliente.Create(5, 'Eduardo Lima',   '98765432100');

  Writeln('INSERINDO CLIENTES');
  for I := 1 to 5 do
    Clientes[I].Inserir;

  // carros
  Carros[1] := TCarro.Create(1, 'Marea',  StrToDate('15/03/2021'));
  Carros[2] := TCarro.Create(2, 'Uno',    StrToDate('10/06/2019'));
  Carros[3] := TCarro.Create(3, 'Gol',    StrToDate('20/05/2022'));
  Carros[4] := TCarro.Create(4, 'Palio',  StrToDate('01/01/2020'));
  Carros[5] := TCarro.Create(5, 'Siena',  StrToDate('15/08/2018'));

  Writeln('INSERINDO CARROS:');
  for I := 1 to 5 do
    Carros[I].Inserir;

  // vendas
  Vendas[1] := TVenda.Create(1, 1, 1, StrToDate('01/05/2021'), 45000);
  Vendas[2] := TVenda.Create(2, 2, 2, StrToDate('03/05/2021'), 30000);
  Vendas[3] := TVenda.Create(3, 3, 3, StrToDate('05/05/2021'), 35000);
  Vendas[4] := TVenda.Create(4, 4, 4, StrToDate('07/05/2021'), 28000);
  Vendas[5] := TVenda.Create(5, 5, 5, StrToDate('09/05/2021'), 32000);

  Writeln('INSERINDO VENDAS:');
  for I := 1 to 5 do
    Vendas[I].Inserir;

  for I := 1 to 5 do
  begin
    Clientes[I].Free;
    Carros[I].Free;
    Vendas[I].Free;
  end;

  Readln;
end.