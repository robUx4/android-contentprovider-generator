<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import java.util.Date;
<#if config.useAnnotations>

import android.support.annotation.NonNull;
</#if>

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Immutable implementation of {@link ${entity.nameCamelCase}Key}
</#if>
 *
 * @see ${entity.nameCamelCase}KeyImpl.Builder
 */
public class ${entity.nameCamelCase}KeyImpl implements ${entity.nameCamelCase}Key {
    public static class Builder implements ${entity.nameCamelCase}Key {
    <#list entity.getFields() as field>
        <#if field.isId || field.isKey>
        private ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
        </#if> 
    </#list>

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link ${entity.nameCamelCase}Model}
         */
        public Builder(${entity.nameCamelCase}Model copy) {
    <#list entity.getFields() as field>
        <#if field.isId || field.isKey>
            this.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> = copy.get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}();
        </#if>
    </#list>
        }
    <#list entity.getFields() as field>
      <#if field.isId || field.isKey>

        <#if config.useAnnotations && !field.isNullable && !field.type.hasNotNullableJavaType()>
        public Builder set<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}(@NonNull ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>) {
        <#elseif config.useAnnotations && field.isNullable>
        public Builder set<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}(@Nullable ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>) {
        <#else>
        public Builder set<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}(${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>) {
        </#if>
            this.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> = <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
            return this;
        }

     <#if config.useAnnotations>
        <#if field.isNullable>
        @Nullable
        <#else>
            <#if !field.type.hasNotNullableJavaType()>
        @NonNull
            </#if>
        </#if>
     </#if>
        @Override
        public ${field.javaTypeSimpleName} get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}() {
            return <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
        }
      </#if>
    </#list>

        public ${entity.nameCamelCase}KeyImpl build() {
        <#list entity.keys as field>
            <#switch field.type.name()>
            <#case "STRING">
            <#case "ENUM">
            <#case "DATE">
            if (null == <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>) throw new IllegalStateException("<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> is a key and cannot be null");
            <#break>
            <#default>
            </#switch>
        </#list>
            return new ${entity.nameCamelCase}KeyImpl(this);
        }
    }

    <#list entity.getFields() as field>
    <#if field.isId || field.isKey>
    private final ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
    </#if> 
    </#list>

    protected ${entity.nameCamelCase}KeyImpl(Builder builder) {
    <#list entity.getFields() as field>
      <#if field.isId || field.isKey>
        this.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> = builder.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
      </#if>
    </#list>
    }
    <#list entity.getFields() as field>
    <#if field.isId || field.isKey>

    /**
    <#if field.documentation??>
     * ${field.documentation}
    <#else>
     * Get the {@code ${field.nameLowerCase}} value.
    </#if>
        <#if field.isNullable>
     * Can be {@code null}.
        <#else>
            <#if !field.type.hasNotNullableJavaType()>
     * Cannot be {@code null}.
            </#if>
        </#if>
     */
     <#if config.useAnnotations>
        <#if field.isNullable>
    @Nullable
        <#else>
            <#if !field.type.hasNotNullableJavaType()>
    @NonNull
            </#if>
        </#if>
     </#if>
    @Override
    public ${field.javaTypeSimpleName} get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}() {
        return <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
    }
    </#if>
    </#list>

    @Override
    public boolean equals(Object o) {
        if (o==this) return true;
        if (!(o instanceof ${entity.nameCamelCase}Key)) return false;
        return
        <#list entity.keys as field>
        <#switch field.type.name()>
        <#default>
            <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>.equals(((${entity.nameCamelCase}Key) o).get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}())<#if field_has_next> && <#else>;</#if>
        <#break>
        <#case "BOOLEAN">
        <#case "INTEGER">
        <#case "LONG">
        <#case "FLOAT">
        <#case "ENUM">
        <#case "DOUBLE">
            <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> == ((${entity.nameCamelCase}Key) o).get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}()<#if field_has_next> && <#else>;</#if>
        <#break>
        <#case "BYTE_ARRAY">
            Arrays.equals(<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>, ((${entity.nameCamelCase}Key) o).get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}())<#if field_has_next> && <#else>;</#if>
        <#break>
        </#switch>
    </#list>
    }

    @Override
    public int hashCode() {
        int result = 17;
    <#list entity.keys as field>
        <#switch field.type.name()>
        <#default>
        result = 31 * result + <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>.hashCode();
        <#break>
        <#case "BOOLEAN">
        <#case "INTEGER">
        result = 31 * result + <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
        <#break>
        <#case "LONG">
        result = 31 * result + (int) (<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> ^ (<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> >>> 32));
        <#break>
        <#case "FLOAT">
        result = 31 * result + Float.floatToIntBits(<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>);
        <#break>
        <#case "DOUBLE">
        long doubleFieldBits = Double.doubleToLongBits(<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>);
        result = 31 * result + (int) (doubleFieldBits ^ (doubleFieldBits >>> 32));
        <#break>
        <#case "BYTE_ARRAY">
        result = 31 * result + Arrays.hashCode(<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>);
        <#break>
        </#switch>
    </#list>
        return result;
    }
}
