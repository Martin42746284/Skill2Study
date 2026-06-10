import AdminLayout from "@/components/AdminLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Textarea } from "@/components/ui/textarea";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  ClipboardCheck,
  Plus,
  MoreHorizontal,
  Eye,
  Pencil,
  Trash2,
  BarChart3,
  HelpCircle,
  Users,
  TrendingUp,
} from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { useToast } from "@/hooks/use-toast";
import { admin, tests as testsApi } from "@/lib/api";

const categories = ["Intérêts", "Compétences", "Personnalité", "Valeurs"];
const categoryKeys = { "Intérêts": "interests", "Compétences": "skills", "Personnalité": "personality", "Valeurs": "values" };

const AdminTests = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [questions, setQuestions] = useState<any[]>([]);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [viewDialogOpen, setViewDialogOpen] = useState(false);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [editingQuestion, setEditingQuestion] = useState<any | null>(null);
  const [viewingQuestion, setViewingQuestion] = useState<any | null>(null);
  const [deletingQuestionId, setDeletingQuestionId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);

  // Form
  const [formText, setFormText] = useState("");
  const [formCategory, setFormCategory] = useState("Intérêts");
  const [formOptions, setFormOptions] = useState<string[]>(["", ""]);

  useEffect(() => {
    const fetchQuestions = async () => {
      try {
        setLoading(true);
        const response = await testsApi.getQuestions() as any;
        let questionsData = [];

        if (Array.isArray(response)) {
          questionsData = response;
        } else if (response?.questions && Array.isArray(response.questions)) {
          questionsData = response.questions;
        } else if (response?.data && Array.isArray(response.data)) {
          questionsData = response.data;
        }

        setQuestions(questionsData);
      } catch (error) {
        toast({
          title: t("common.error"),
          description: error instanceof Error ? error.message : t("admin.pages.tests.loadingError"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };

    fetchQuestions();
  }, [toast, t]);

  const totalQuestions = questions.length;
  const questionsByCategory = categories.map((cat) => ({
    name: cat,
    count: questions.filter((q) => q.categorie === cat).length,
  }));

  const openAddDialog = () => {
    setEditingQuestion(null);
    setFormText("");
    setFormCategory("Intérêts");
    setFormOptions(["", ""]);
    setDialogOpen(true);
  };

  const openEditDialog = (question: any) => {
    setEditingQuestion(question);
    setFormText(question.texte || question.text || "");
    setFormCategory(question.categorie || question.category || "Intérêts");
    const options = question.options ? question.options.map((o: any) => o.texte || o.text || "") : ["", ""];
    setFormOptions(options);
    setDialogOpen(true);
  };

  const handleSave = async () => {
    try {
      // Validation du texte
      if (!formText.trim()) {
        toast({
          title: t("common.error"),
          description: "Le texte de la question est requis",
          variant: "destructive"
        });
        return;
      }

      if (formText.trim().length < 10) {
        toast({
          title: t("common.error"),
          description: "Le texte doit contenir au moins 10 caractères",
          variant: "destructive"
        });
        return;
      }

      const options = formOptions.filter(o => o.trim()).map(o => ({ texte: o }));

      if (!options.length) {
        toast({
          title: t("common.error"),
          description: t("admin.pages.tests.addAnswerRequired"),
          variant: "destructive"
        });
        return;
      }

      if (editingQuestion) {
        const updateData = {
          texte: formText,
          categorie: formCategory,
          options: options,
        };
        const response = await admin.updateQuestion(editingQuestion.id, updateData as any);
        // Combiner la réponse du backend avec nos données locales (pour les options)
        const backendQuestion = (response as any).question || {};
        const updatedQuestion = {
          ...backendQuestion,
          texte: formText,
          categorie: formCategory,
          options: (response as any).question?.options || options,
        };
        setQuestions(questions.map((q) => (q.id === editingQuestion.id ? updatedQuestion : q)));
        toast({ title: t("admin.pages.tests.editTest"), description: t("admin.pages.tests.questionUpdated") });
      } else {
        const createData = {
          texte: formText,
          categorie: formCategory,
          options: options,
        };
        const response = await admin.createQuestion(createData as any);
        const newQuestion = (response as any).question || (response as any);
        setQuestions([...questions, newQuestion]);
        toast({ title: t("admin.pages.tests.addTest"), description: t("admin.pages.tests.questionAdded") });
      }
      setDialogOpen(false);
    } catch (error) {
      toast({ title: t("common.error"), description: error instanceof Error ? error.message : t("admin.pages.tests.saveError"), variant: "destructive" });
    }
  };

  const handleDelete = async () => {
    if (deletingQuestionId !== null) {
      try {
        await admin.deleteQuestion(deletingQuestionId);
        setQuestions(questions.filter((q) => q.id !== deletingQuestionId));
        toast({ title: t("admin.pages.tests.deleteTest"), variant: "destructive" });
        setDeleteDialogOpen(false);
        setDeletingQuestionId(null);
      } catch (error) {
        toast({ title: t("common.error"), description: t("admin.pages.tests.deleteError"), variant: "destructive" });
      }
    }
  };

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-screen">
          <p className="text-muted-foreground">{t("common.loading")}</p>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="animate-fade-in">
        <div className="mb-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <p className="text-sm text-muted-foreground">{questions.length} {t("admin.pages.tests.questions")}</p>
          </div>
          <Button size="sm" onClick={openAddDialog}>
            <Plus className="h-4 w-4 mr-1" /> {t("admin.pages.tests.addTest")}
          </Button>
        </div>

        {/* Quick stats */}
        <div className="mb-8 grid gap-4 sm:grid-cols-4">
          {[
            { icon: HelpCircle, value: totalQuestions, label: t("admin.pages.tests.questions"), color: "bg-primary/10 text-primary" },
            { icon: ClipboardCheck, value: questionsByCategory[0]?.count || 0, label: t("admin.pages.tests.interests"), color: "bg-secondary/10 text-secondary" },
            { icon: Users, value: questionsByCategory[1]?.count || 0, label: t("admin.pages.tests.skills"), color: "bg-success/10 text-success" },
            { icon: TrendingUp, value: questionsByCategory[2]?.count || 0, label: t("admin.pages.tests.personality"), color: "bg-info/10 text-info" },
          ].map((s) => (
            <div key={s.label} className="rounded-xl border bg-card p-4 shadow-card">
              <div className="flex items-center gap-3">
                <div className={`flex h-9 w-9 items-center justify-center rounded-lg ${s.color}`}>
                  <s.icon className="h-4 w-4" />
                </div>
                <div>
                  <p className="text-xl font-bold">{s.value}</p>
                  <p className="text-xs text-muted-foreground">{s.label}</p>
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Categories */}
        <div className="mb-8 rounded-xl border bg-card p-6 shadow-card">
          <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
            <BarChart3 className="h-5 w-5 text-primary" /> {t("admin.pages.tests.categoryBreakdown")}
          </h2>
          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            {questionsByCategory.map((cat, i) => (
              <div key={cat.name} className="flex items-center gap-3 rounded-lg border p-3">
                <div className={`flex h-8 w-8 items-center justify-center rounded-lg ${["bg-primary/10 text-primary", "bg-secondary/10 text-secondary", "bg-info/10 text-info", "bg-warning/10 text-warning"][i % 4]}`}>
                  <HelpCircle className="h-4 w-4" />
                </div>
                <div>
                  <p className="text-sm font-medium">{t(`admin.pages.tests.${categoryKeys[cat.name as keyof typeof categoryKeys]}`)}</p>
                  <p className="text-xs text-muted-foreground">{cat.count} {t("admin.pages.tests.questions").toLowerCase()}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Questions list */}
        <div className="space-y-4">
          {questions.map((question) => (
            <div key={question.id} className="rounded-xl border bg-card p-5 shadow-card hover:shadow-card-hover transition-shadow">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div className="flex items-start gap-4 flex-1">
                  <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-primary/10">
                    <HelpCircle className="h-5 w-5 text-primary" />
                  </div>
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      <h3 className="font-semibold text-sm">{question.texte || question.text || t("admin.pages.tests.noTitle")}</h3>
                      <Badge variant="secondary" className="text-[10px]">{t(`admin.pages.tests.${categoryKeys[question.categorie as keyof typeof categoryKeys]}`) || question.category || 'N/A'}</Badge>
                    </div>
                    <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs text-muted-foreground">
                      {question.options && <span>{question.options.length} {t("admin.pages.tests.answers")}</span>}
                    </div>
                  </div>
                </div>
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="icon" className="h-8 w-8">
                      <MoreHorizontal className="h-4 w-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end">
                    <DropdownMenuItem onClick={() => { setViewingQuestion(question); setViewDialogOpen(true); }}>
                      <Eye className="h-4 w-4 mr-2" /> {t("admin.pages.tests.viewDetails")}
                    </DropdownMenuItem>
                    <DropdownMenuItem onClick={() => openEditDialog(question)}>
                      <Pencil className="h-4 w-4 mr-2" /> {t("admin.pages.tests.editAction")}
                    </DropdownMenuItem>
                    <DropdownMenuItem className="text-destructive" onClick={() => { setDeletingQuestionId(question.id); setDeleteDialogOpen(true); }}>
                      <Trash2 className="h-4 w-4 mr-2" /> {t("admin.pages.tests.deleteAction")}
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>
            </div>
          ))}
        </div>

        {/* Add/Edit Dialog */}
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-lg max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>{editingQuestion ? t("admin.pages.tests.editTest") : t("admin.pages.tests.addTest")}</DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-2">
              <div className="space-y-1.5">
                <Label>{t("admin.pages.tests.formName")}</Label>
                <Textarea
                  placeholder={t("admin.pages.tests.questionPlaceholder")}
                  value={formText}
                  onChange={(e) => setFormText(e.target.value)}
                  className="min-h-[80px]"
                />
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.tests.category")}</Label>
                <Select value={formCategory} onValueChange={setFormCategory}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>
                    {categories.map((c) => (
                      <SelectItem key={c} value={c}>
                        {t(`admin.pages.tests.${categoryKeys[c as keyof typeof categoryKeys]}`)}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>{t("admin.pages.tests.answers")}</Label>
                <div className="space-y-2">
                  {formOptions.map((option, idx) => (
                    <div key={idx} className="flex gap-2">
                      <Input
                        placeholder={t("admin.pages.tests.answerPlaceholder") + ` ${idx + 1}`}
                        value={option}
                        onChange={(e) => {
                          const newOptions = [...formOptions];
                          newOptions[idx] = e.target.value;
                          setFormOptions(newOptions);
                        }}
                      />
                      {formOptions.length > 2 && (
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => {
                            const newOptions = formOptions.filter((_, i) => i !== idx);
                            setFormOptions(newOptions);
                          }}
                        >
                          ✕
                        </Button>
                      )}
                    </div>
                  ))}
                </div>
                <Button
                  variant="outline"
                  size="sm"
                  className="w-full"
                  onClick={() => setFormOptions([...formOptions, ""])}
                >
                  <Plus className="h-4 w-4 mr-1" /> {t("admin.pages.tests.addNew")}
                </Button>
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setDialogOpen(false)}>{t("admin.pages.tests.cancel")}</Button>
              <Button onClick={handleSave} disabled={!formText.trim()}>
                {editingQuestion ? t("admin.pages.tests.save") : t("admin.pages.tests.addNew")}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* View Dialog */}
        <Dialog open={viewDialogOpen} onOpenChange={setViewDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{t("admin.pages.tests.viewDetails")}</DialogTitle>
            </DialogHeader>
            {viewingQuestion && (
              <div className="space-y-4 py-2">
                <div>
                  <p className="text-sm font-medium mb-2">{t("admin.pages.tests.formName")} :</p>
                  <p className="text-sm text-muted-foreground p-3 bg-muted rounded">{viewingQuestion.texte || viewingQuestion.text}</p>
                </div>
                <div>
                  <Badge variant="secondary">{t(`admin.pages.tests.${categoryKeys[viewingQuestion.categorie as keyof typeof categoryKeys]}`) || viewingQuestion.category}</Badge>
                </div>
                {viewingQuestion.options && (
                  <div>
                    <p className="text-sm font-medium mb-2">{t("admin.pages.tests.answers")} ({viewingQuestion.options.length}) :</p>
                    <div className="space-y-1">
                      {viewingQuestion.options.map((opt: any, i: number) => (
                        <p key={i} className="text-xs text-muted-foreground">• {opt.texte || opt.text || t("admin.pages.tests.option") + ` ${i + 1}`}</p>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            )}
          </DialogContent>
        </Dialog>

        {/* Delete Confirmation */}
        <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.pages.tests.deleteConfirmTitle")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.pages.tests.irreversibleAction")}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>{t("admin.pages.tests.cancel")}</AlertDialogCancel>
              <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                {t("admin.pages.tests.delete")}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
};

export default AdminTests;
