vcl 4.1;
backend default {
.host = "0:0";
}
sub vcl_recv {
if (req.http.host ~ "edgeone.cloud")
{
return (vcl(label-edgeone));
}
else if (req.http.host ~ "my.workstation.co.uk")
{
return (vcl(label-crm_workstation));
}
else if (req.http.host ~ "default.edgeone.cloud")
{
return (vcl(label-default));
}
else if (req.http.host ~ "edgeone.edgeone.cloud")
{
return (vcl(label-edgeone));
}
else if (req.http.host ~ "www.jobshout.com")
{
return (vcl(label-jobshout));
}
else if (req.http.host ~ "www.tenthmatrix.co.uk")
{
return (vcl(label-tenthmatrix));
}
else {
return (synth(404));
}
}
