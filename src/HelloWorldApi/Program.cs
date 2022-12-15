var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello World!");

// fake health check endpoint
app.MapGet("/healthz", () => "{}");

app.Run();
