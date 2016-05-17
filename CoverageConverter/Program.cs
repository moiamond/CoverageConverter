namespace CoverageConverter
{
    using System;
    using System.Xml;
    using System.Xml.Xsl;
    using Microsoft.VisualStudio.Coverage.Analysis;
    using System.Data;

    // http://codetuner.blogspot.tw/2011/09/convert-mstest-code-covarage-results-in.html

    class Program
    {
        static int Main(string[] args)
        {
            string wspath = Environment.CurrentDirectory.ToString();
            //args[0] = "data.coverage";
            int ret = -1;
            if (System.IO.File.Exists(args[0]))
            {
                CoverageInfo coverage = CoverageInfo.CreateFromFile(args[0]);
                DataSet data = coverage.BuildDataSet(null);

                //string coveragexml = wspath + @"\vstest.coveragexml";
                string stylexslt = wspath + @"\style.xslt";

                if (System.IO.File.Exists(stylexslt))
                {

                    data.WriteXml(wspath + @"\vstest.coveragexml");

                    string xml = data.GetXml();

                    XmlDocument xmlDocument = new XmlDocument();
                    xmlDocument.LoadXml(xml);


                    XslCompiledTransform myXslTransform = new XslCompiledTransform();
                    XmlTextWriter writer = new XmlTextWriter(wspath + @"\converted.coverage.htm", null);

                    myXslTransform.Load(stylexslt);
                    myXslTransform.Transform(xmlDocument, null, writer);

                    writer.Flush();
                    writer.Close();
                    ret = 0;
                }
            }
            return ret;
        }
    }
}
