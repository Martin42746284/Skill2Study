import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { CalendarDays, Clock, ArrowRight } from "lucide-react";
import { useTranslation } from "react-i18next";

const categoryColors: Record<string, string> = {
  Guidance: "bg-primary/10 text-primary",
  Orientation: "bg-primary/10 text-primary",
  Career: "bg-success/10 text-success",
  Carrière: "bg-success/10 text-success",
  Comparison: "bg-accent text-accent-foreground",
  Comparatif: "bg-accent text-accent-foreground",
  Testimonial: "bg-secondary text-secondary-foreground",
  Témoignage: "bg-secondary text-secondary-foreground",
  Financing: "bg-primary/10 text-primary",
  Financement: "bg-primary/10 text-primary",
  Advice: "bg-destructive/10 text-destructive",
  Conseils: "bg-destructive/10 text-destructive",
};

const Blog = () => {
  const { t } = useTranslation();

  const articles = t("blog.articles", { returnObjects: true }) as Array<{
    title: string;
    excerpt: string;
    category: string;
    date: string;
    readTime: string;
    image: string;
  }>;

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      <main className="container mx-auto px-4 pt-24 pb-16">
        <div className="max-w-5xl mx-auto">
          <div className="text-center mb-12">
            <h1 className="text-4xl font-bold mb-4">{t("blog.title")}</h1>
            <p className="text-lg text-muted-foreground">
              {t("blog.description")}
            </p>
          </div>

          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {articles.map((article, index) => (
              <Card key={index} className="group hover:shadow-lg transition-all duration-300 hover:-translate-y-1 cursor-pointer">
                <CardHeader className="pb-3">
                  <div className="text-5xl mb-3">{article.image}</div>
                  <Badge variant="outline" className={categoryColors[article.category] || ""}>
                    {article.category}
                  </Badge>
                </CardHeader>
                <CardContent className="space-y-3">
                  <h2 className="text-lg font-semibold leading-snug group-hover:text-primary transition-colors">
                    {article.title}
                  </h2>
                  <p className="text-sm text-muted-foreground leading-relaxed line-clamp-3">
                    {article.excerpt}
                  </p>
                  <div className="flex items-center justify-between pt-2 text-xs text-muted-foreground">
                    <span className="flex items-center gap-1">
                      <CalendarDays className="h-3.5 w-3.5" />
                      {article.date}
                    </span>
                    <span className="flex items-center gap-1">
                      <Clock className="h-3.5 w-3.5" />
                      {article.readTime}
                    </span>
                  </div>
                  <div className="flex items-center gap-1 text-sm font-medium text-primary pt-1 group-hover:gap-2 transition-all">
                    {t("blog.readArticle")} <ArrowRight className="h-4 w-4" />
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default Blog;
