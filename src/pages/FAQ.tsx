import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from "@/components/ui/accordion";
import { useTranslation } from "react-i18next";

const FAQ = () => {
  const { t } = useTranslation();

  const categories = [
    { key: "general", label: t("faq.categories.general.title") },
    { key: "tests", label: t("faq.categories.tests.title") },
    { key: "recommendations", label: t("faq.categories.recommendations.title") },
    { key: "account", label: t("faq.categories.account.title") },
  ];

  const getCategoryItems = (categoryKey: string) => {
    return t(`faq.categories.${categoryKey}.items`, { returnObjects: true }) as Array<{
      question: string;
      answer: string;
    }>;
  };

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      <main className="container mx-auto px-4 pt-24 pb-16">
        <div className="max-w-3xl mx-auto">
          <div className="text-center mb-12">
            <h1 className="text-4xl font-bold mb-4">{t("faq.title")}</h1>
            <p className="text-lg text-muted-foreground">
              {t("faq.description")}
            </p>
          </div>

          <div className="space-y-8">
            {categories.map((category, catIndex) => (
              <div key={catIndex}>
                <h2 className="text-xl font-semibold mb-4 text-primary">{category.label}</h2>
                <Accordion type="single" collapsible className="space-y-2">
                  {getCategoryItems(category.key).map((item, itemIndex) => (
                    <AccordionItem key={itemIndex} value={`${catIndex}-${itemIndex}`} className="border rounded-lg px-4">
                      <AccordionTrigger className="text-left hover:no-underline">
                        {item.question}
                      </AccordionTrigger>
                      <AccordionContent className="text-muted-foreground leading-relaxed">
                        {item.answer}
                      </AccordionContent>
                    </AccordionItem>
                  ))}
                </Accordion>
              </div>
            ))}
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default FAQ;
